--http://portal.vuso.ua/issues/127289
--Генерация Го.МВД. Описание алгоритма

--1. Ищем свободный ключ во временной таблице
select t.int_field1, count(*) from t_temp_table t where t.int_field1 between 992 and 999 group by 1
--delete from t_temp_table t where t.int_field1 = 999

--2. Заполнить временную таблицу

--"ID операции (87552, 87555)"                       - 87552,
--"ID во временной таблице (999)"                    - 999,
--"Начало нумерации бланков (NULL - не нумеровать)"  - XXXXXXX номер с,
--"Конец нумерации бланков"                          - XXXXXXX номер по,
--"Номер архивного тома (NULL - без архивных)"       - 306,    --Тот, что дала Коряковская (первый)
--"Архивный номер в томе (1..999)"                   - 1       --Первый номер в томе

/*
 *  Формирование реестра платежей для генерации Го.МВД
 *  Заполнение временной таблицы с параметрами генерируемых договоров страхования
 */
execute block (

  id_oper tinteger = :"ID операции (87552, 87555)",
  id_temp tinteger = :"ID во временной таблице (999)",
  first_blank tinteger = :"Начало нумерации бланков (NULL - не нумеровать)",
  last_blank tinteger = :"Конец нумерации бланков",
  tome_num tinteger = :"Номер архивного тома (NULL - без архивных)",
  arch_num tinteger = :"Архивный номер в томе (1..999)" 
)
as
  declare variable id_payment tinteger;
  declare variable customer type of column f_dt_payments.customer;
  declare variable pay_sum tmoney;
  declare variable doc_sum tmoney;
  declare variable ins_sum tmoney;
  declare variable pay_date tdate;
  declare variable end_date tdate;
  declare variable ins_type tvarchar4;
begin
  if (:tome_num is not null and :arch_num is null) then arch_num = 1;

  for
    select p.id_payment, p.customer, p.fact_sum, cf.cf_date
    from f_dt_payments p
      inner join f_dt_cash_flow cf
        on p.id_cash_flow = cf.id_cash_flow
    where p.id_operation = :id_oper
	--and cf.cf_date >= '01.05.2016' -- Поправка... 2 платежа в апреле!!!
    order by p.cf_division, cf.cf_date
    into :id_payment, :customer, :pay_sum, :pay_date
  do
  begin
    doc_sum = :pay_sum;
    -- Определяем вид страхования
    ins_type = case
      when :doc_sum in (10, 40) then 'НС'
      when :doc_sum = 30 then 'ИМ'
      when :doc_sum in (50, 60, 75, 100, 150) then 'ВЗР'
      when :doc_sum in (80, 140, 160, 200, 240, 280, 300, 320, 340, 360, 380, 400, 600) then 'ДПРТ'
      when :doc_sum in (120, 125, 170, 182, 245, 272, 350, 392, 420, 425, 450, 476, 480, 500, 680, 686, 800, 980) then 'МДС'
      else null
    end;
    -- Определяем страховую сумму
    ins_sum = case
      when :ins_type = 'НС' then 5000
      when :ins_type = 'ИМ' then 1000
      when :ins_type = 'ВЗР' then 50000
      when :ins_type = 'ДПРТ' then 20000
      when :ins_type = 'МДС' then 40000
      else null
    end;

    if (:ins_sum is not null) then
    begin
      -- Правим платежи
      update f_dt_payments p
      set p.memo_1 = null,
        p.memo_3 = :ins_type
      where p.id_payment = :id_payment;

      -- Вычисление даты окончания договора
      end_date = dateadd(-1 day to
        case
          when :doc_sum in (30, 50, 60, 75, 100, 150, 400, 480, 500, 600, 680, 980) then dateadd(1 year to :pay_date)
          else dateadd(
            case
              when :doc_sum in (10, 80, 120, 125, 170, 245) then 1
              when :doc_sum in (140, 182) then 2
              when :doc_sum in (160, 272, 392) then 3
              when :doc_sum = 200 then 4
              when :doc_sum = 240 then 5
              when :doc_sum in (40, 280, 350, 476, 686) then 6
              when :doc_sum = 300 then 7
              when :doc_sum = 320 then 8
              when :doc_sum in (340, 420, 425) then 9
              when :doc_sum in (360, 450) then 10
              when :doc_sum = 380 then 11
              when :doc_sum = 800 then 24
              else 12
            end
            month to :pay_date
          )
        end
      );

      -- Создаем запись в темповой таблице
      update or insert into t_temp_table (
        INT_FIELD1,  -- Уникальный ID во временной таблице
        INT_FIELD2,  -- ID_PAYMENT
        INT_FIELD3,  -- ИД тарифочлена (один из 4166, 4180, 4251, 4255, 4279, 4281, 4282 или 4317 для медицины)
        DATE_FIELD1, -- дата договора (в пределах 01.01.2011 - 31.12.2014)
        DATE_FIELD2, -- дата начала (равна дате договора)
        DATE_FILED3, -- дата окончания (дата начала + 1..12 месяцев минус 1 день)
        STR_FIELD1,  -- содержит номер бланка для генерируемого договора
        STR_FIELD2,  -- ФИО контрагента (или NULL, если требуется генерация ФИО)
        STR_FIELD3,  -- вид страхования (ИМ, ВЗР, ДПРТ, НС), медицина (МДС) не генерируется
        STR_FIELD4,  -- архивный номер
        CURR_FIELD1, -- страховая сумма по договору
        CURR_FIELD2, -- страховой тариф по договору ( = CURR_FILED3 / CURR_FIELD1 * 100 )
        CURR_FILED3  -- страховой платеж по договору.
      )
      values (
        :id_temp, 
        :id_payment, 
        case
          when :ins_type = 'НС' then 4166
          when :ins_type = 'ИМ' then 4180
          when :ins_type = 'ДПРТ' then 20660
          when :ins_type = 'ВЗР' then 20661
          when :ins_type = 'МДС' then 20662
          else null
        end,
        :pay_date,
        :pay_date,
        :end_date,
        :first_blank,
        :customer,
        :ins_type,
        (extract(year from :pay_date) - 2000) || '-' || right('00' || :tome_num, 3) || '/' || right('00' || :arch_num, 3),
        :ins_sum,
        :doc_sum * 100 / :ins_sum,
        :doc_sum
      )
      matching (int_field1, int_field2);

      -- Номер следующего бланка
      if (:first_blank is not null) then
      begin
        first_blank = :first_blank + 1;

        if (:first_blank > coalesce(:last_blank, 9999999)) then
          first_blank = null;
      end

      -- Следующий архивный номер
      if (:tome_num is not null) then
      begin
        arch_num = :arch_num + 1;
        if (:arch_num > 999) then
        begin
          tome_num = :tome_num + 1;
          arch_num = 1;
        end
      end
    end
  end
end

/*

--Посмотреть, что во временной таблице

select
  t.int_field1 as id_temp,
  t.int_field2 as id_payment,
  t.int_field3 as id_tariff_member,
  t.int_field4 as id_doc,
  t.int_field5 as id_operation,
  t.date_field1 as doc_date,
  t.date_field2 as inure_date,
  t.date_filed3 as end_date,
  t.str_field1 as doc_number,
  t.str_field2 as customer,
  t.str_field3 as ins_type,
  t.str_field4 as arch_num,
  t.curr_field1 as ins_sum,
  t.curr_field2 as tariff,
  t.curr_filed3 as ins_pay
from t_temp_table t
where t.int_field1 in (999)

*/