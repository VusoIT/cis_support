SET TERM ^ ;

create or alter procedure XD_GENERATE_FULL (
    DOC_TYPE TVARCHAR10,
    ID_TEMP_KEY TINTEGER)
returns (
    RESULT varchar(30000))
as
declare variable ID_PAY TVARCHAR100;
declare variable DESCR TVARCHAR400;
declare variable CUSTOMER TVARCHAR400;
declare variable DOC_DATE TDATE;
declare variable DOC_BEGIN_DATE TDATE;
declare variable DOC_END_DATE TDATE;
declare variable PLAN_INS_SUM TNUMERIC16_2;
declare variable PLAN_INS_TARIFF TNUMERIC16_2;
declare variable PLAN_INS_PAY TNUMERIC16_2;
declare variable SUM_PAY TNUMERIC16_2;
declare variable ID_TARIFF TINTEGER;
declare variable MEMO TVARCHAR400;
declare variable MEMO1 TVARCHAR400;
declare variable MEMO2 TVARCHAR400;
declare variable MEMO3 TVARCHAR400;
declare variable REG_NUM_STR TVARCHAR400;
declare variable REG_NUM_ID TINTEGER;
declare variable ARCH_NUM_ID TINTEGER;
declare variable ARCH_NUM_STR TVARCHAR400;
declare variable ID_DOC_TYPE TINTEGER;
declare variable ID_MIN TINTEGER;
declare variable ID_MAX TINTEGER;
declare variable ID_TMP TINTEGER;
declare variable BIRTH_DATE TDATE;
declare variable BIRTH_DAY TINTEGER;
declare variable BIRTH_YEAR TINTEGER;
declare variable COUNTER TINTEGER;
declare variable PACHKA_SIZE TINTEGER;
declare variable PAKETOS TINTEGER;
declare variable ALLOW_GENERATE TINTEGER;
declare variable END_POS TINTEGER;
declare variable ARCH_TOM_NUM_ID TINTEGER;
declare variable ARCH_NUM_MIN_ID TINTEGER;
declare variable ARCH_NUM_MAX_ID TINTEGER;
declare variable DOC_NUM_MIN TINTEGER;
declare variable DOC_NUM_MAX TINTEGER;
declare variable PAY_DATE_MIN TDATE;
declare variable PAY_DATE_MAX TDATE;
declare variable ID_OPERATION TINTEGER;
begin
  /* Описание T_TEMP_TABLE
  int_field1  - признак выборки записей для генерации, по умолчанию 999
  int_field2  - идентификатор платежа
  int_field3  - идентификатор тарифной сетки договора страхования
  int_field4  - идентификатор договора страховаиня
  date_field1 - дата заключения договора страхования
  date_field2 - дата вступления в действие договора страхования
  date_filed3 - дата окончания дейтсвия договора страхования
  str_field1  - номер договора страхования (содежит только номер бланка)
  str_field2  - контрагент по договору страхования (страхователь)
  str_field3  - вид страхования
  str_field4  - архивный номер договора страхования
  curr_field1 - страховая сумма по договору
  curr_field2 - страховой тариф по договору
  curr_filed3 - страховой платеж по договору

  select
    t.int_field1 as id_temp,
    t.int_field2 as id_payment,
    t.int_field3 as id_tariff_member,
    t.int_field4 as id_doc,
    t.date_field1 as doc_date,
    t.date_field2 as inure_date,
    t.date_filed3 as end_date,
    t.str_field1 as blank_number,
    t.str_field2 as customer,
    t.str_field3 as ins_type,
    t.str_field4 as arch_number,
    t.curr_field1 as ins_sum,
    t.curr_field2 as tariff,
    t.curr_filed3 as ins_pay
  from t_temp_table t
  where t.int_field1 = 995
  */

  /* инициализация переменных */
  -- Архивный том
  arch_num_min_id = 701;--перед новой генерацией, изменить на последний номер тома
  arch_num_max_id = 705;
  -- номер в архиве
  arch_tom_num_id = 1;
  -- номера договоров
  doc_num_min = 2518135;
  doc_num_max = 2522605;
  -- даты выборки
  pay_date_min = cast('01.10.2015' as tdate);
  pay_date_max = cast('31.10.2015' as tdate);
  -- операция для отбора платедей (87552 по-умолчанию, иногда 87555)
  id_operation = 87552;

  /* установка базовых значений */
  arch_num_id = :arch_num_min_id;
  if (:id_temp_key is null) then id_temp_key = 999;

  /* установка генератора, СДЕЛАТЬ ОДИН РАЗ!!! */
  --ALTER SEQUENCE GEN_XD_GENERATE_FULL RESTART WITH :doc_num_min;

  /* выбор типа генерации: автоматическая (по всем видам) или ручная (по одному виду) */
  if ((:DOC_TYPE is null) or (:DOC_TYPE = '')) -- проверка задания типа генерируемого договора
  then -- если тип договора не задан - генерим по всем типам договоров
    begin
      paketos = 0;
      allow_generate = 1;
    end
  else -- если тип задан - генерим только по заданному типу
    begin
      paketos = 4;
      allow_generate = 0;
    end

  /* запуск генерации */
  while (:paketos < 5) do
  begin
    if (:allow_generate = 1) then
    begin
      if (:paketos = 0) then DOC_TYPE = 'ИМ'; -- id_doc_type = 5; -- паспорт
      if (:paketos = 1) then DOC_TYPE = 'ВЗР'; -- id_doc_type = 38; -- ВЗР
      if (:paketos = 2) then DOC_TYPE = 'ДПРТ';-- id_doc_type = 22; -- ОТЛ
      if (:paketos = 3) then DOC_TYPE = 'МДС'; -- id_doc_type = 16; -- МЕД
      if (:paketos = 4) then DOC_TYPE = 'НС'; -- id_doc_type = 6; -- НС
    end

    if (:DOC_TYPE = 'ИМ') then id_doc_type = 5; -- паспорт
    if (:DOC_TYPE = 'ВЗР') then id_doc_type = 38; -- ВЗР
    if (:DOC_TYPE = 'ДПРТ') then id_doc_type = 22; -- ОТЛ
    if (:DOC_TYPE = 'МДС') then id_doc_type = 16; -- МЕД
    if (:DOC_TYPE = 'НС') then id_doc_type = 6; -- НС
  
    --управляем количеством договров в одном коммите
    counter = 0;
    pachka_size = 5;
    result = '--delete from t_temp_table where int_field1 = ' || :id_temp_key || ';
             ';

    for
    select --first 2500 --skip 20000
             --'Pay.' || cast(pay.id_payment as tvarchar10) || '-' || 'CF.' || cast(cf.id_cash_flow as tvarchar10),
             cast(pay.id_payment as tvarchar10),
             cf.cf_descr,
             trim(upper(coalesce(tmp.str_field2,pay.customer))),
             coalesce(cast(tmp.date_field1 as tdate),cast(cf.cf_date as tdate)),
             tmp.date_field2, 
             tmp.date_filed3,
             tmp.int_field3,
             tmp.curr_field1,
             tmp.curr_field2,
             tmp.curr_filed3,
             pay.fact_sum,
             pay.memo,
             pay.memo_1,
             pay.memo_2,
             pay.memo_3,
             tmp.str_field1,
             tmp.str_field4
        from f_dt_payments pay
       inner join f_dt_cash_flow cf
          on cf.id_cash_flow = pay.id_cash_flow
       inner join t_temp_table tmp
          on tmp.int_field1 = :id_temp_key
         and tmp.int_field2 = pay.id_payment
       where cf.cf_date between :pay_date_min and :pay_date_max
         and pay.cf_type in (26, 123, 148)
         and pay.cf_division in (1497, 88)
         and coalesce(pay.id_operation, -1) = :id_operation
         and coalesce(pay.id_doc, -1) = -1
         and cf.cf_cl_type = 1
         and not coalesce(pay.memo,'') starting with 'Операция'
         and not pay.memo_3 is null
         --для тестирования закомментила
         and upper(pay.memo_3) = UPPER(:doc_type)
         and tmp.int_field4 is null
         /**
         and pay.id_payment in (5752768, 5752769)
         /**/
        into :id_pay,
             :descr,
             :customer,
             :doc_date,
             :doc_begin_date,
             :doc_end_date,
             :id_tariff,
             :plan_ins_sum,
             :plan_ins_tariff,
             :plan_ins_pay,
             :sum_pay,
             :memo,
             :memo1,
             :memo2,
             :memo3,
             :reg_num_str,
             :arch_num_str
    do
      begin
        result = '';

  --------------------------------------------------------------------------------
  ----кастомер
  
        if ((:customer is null) or (:customer = '')) then
        begin
          for select cast(round(rand() * 300000,0) as tinteger),
                     cast(round(rand() * 400000,0) as tinteger)
                from sys_options sys
                into :id_min,
                     :id_max
          do
          begin
            if (:id_min > :id_max) then
            begin
              ID_tmp = :id_max;
              id_max = :id_min;
              id_min = :id_tmp;
            end
        
            select first 1  skip 100
                   nat.last_name || ' ' || nat.first_name
              from c_sp_naturals nat
             where nat.id_customer between :id_min and :id_max
               and nat.citizenship = 1
               and nat.last_name is not null
               and nat.first_name is not null
               and nat.last_name <> ''
               and nat.first_name <> ''
              into :customer;
          end
        end
        else
        if (position(' ', :customer) = 0) then
        begin
          for select cast(round(rand() * 300000,0) as tinteger),
                     cast(round(rand() * 400000,0) as tinteger)
                from sys_options sys
                into :id_min,
                     :id_max
          do
          begin
            if (:id_min > :id_max) then
            begin
              ID_tmp = :id_max;
              id_max = :id_min;
              id_min = :id_tmp;
            end
        
            select first 1  skip 100
                   :customer || ' ' || upper(left(nat.first_name, 1)) || ' ' || upper(left(nat.patronimic_name, 1))
              from c_sp_naturals nat
             where nat.id_customer between :id_min and :id_max
               and nat.citizenship = 1
               and nat.last_name is not null
               and nat.first_name is not null
               and nat.last_name <> ''
               and nat.first_name <> ''
              into :customer;
          end
        end
  
        --------------------------------------------------------------------------------
        ----дата рождения
        BIRTH_DAY = cast(round(rand() * 365) as tinteger) + 1;
        BIRTH_YEAR = cast(round(rand() * 40) as tinteger) + 1952;
        
        BIRTH_DATE = dateadd(BIRTH_DAY day to cast('01.01.' || BIRTH_YEAR as tdate));
        --------------------------------------------------------------------------------

        -- регистрационный номер договора
        if (:reg_num_str is null)
        then -- если регномер не задан снаружи
          begin
            reg_num_id = gen_id(GEN_XD_GENERATE_FULL,1);
            if (:reg_num_id is null) then exception s_exception 'Пустой номер договора!!!';
            if (:reg_num_id < :doc_num_min) then exception s_exception 'Номера договоров еще не начались!!!';
            if (:reg_num_id > :doc_num_max) then exception s_exception 'Номера договоров закончились!!!';
            reg_num_str = cast(reg_num_id as tvarchar10);
          end

        -- проверка дублирования регистрационного номера договора
        if (
          exists (
            select *
            from d_dt_document d
            where (
                d.reg_num starting with :reg_num_str || '-'
                or (
                  d.num_doc starting with :reg_num_str || '-'
                  and d.num_doc <> :reg_num_str || '-ГО'
                )
              )
              and d.id_state <> 5
          )
        ) then
          exception s_exception 'Договор с таким номером уже есть!!! ' || :reg_num_str;

        -- архивный номер договора
        if (:arch_num_str is null) then -- если архивный номер не задан снаружи
          begin
            if (:arch_num_id is null) then exception s_exception 'Пустой архивный номер договора!!!';
            if (:arch_num_id < :arch_num_min_id) then exception s_exception 'Номера архивных томов еще не начались!!!';
            if (:arch_num_id > :arch_num_max_id) then exception s_exception 'Номера архивных томов закончились!!!';
            arch_num_str = right((extract(year from current_date)),2) ||'-'|| cast(arch_num_id as tvarchar10) || '/' ||
                           iif(char_length(cast(arch_tom_num_id as tvarchar10))=1,'00'||cast(arch_tom_num_id as tvarchar10),iif(char_length(cast(arch_tom_num_id as tvarchar10))=2,'0'||cast(arch_tom_num_id as tvarchar10),cast(arch_tom_num_id as tvarchar10)));
          end

        -- проверка дублирования архивного номера договора
        if (
          exists (
            select *
            from d_dt_document d
            where
                d.arch_num_doc = :arch_num_str
              and d.id_state <> 5
          )
        ) then
          exception s_exception 'Договор с таким архивным номером уже есть!!! ' || :arch_num_str;

        --doc_date = dateadd(-1 day to :doc_date);
        customer = replace(replace(replace(:customer, '''', '`'), '  ', ' '), '  ', ' ');

        -- Обработка
        end_pos = position(' ', :customer);
        if (:end_pos > 0) then
        begin
          end_pos = position(' ', :customer, :end_pos + 1);
          if (:end_pos > 0) then
          begin
            end_pos = position(' ', :customer, :end_pos + 1);
            if (:end_pos > 0) then
                 customer = SUBSTRING(:customer from 1 FOR :end_pos - 1);
          end
        end

        result = result || '/*' || doc_type || '*/ ';

        result = result || (select RESULT from xd_generate(:id_doc_type,
                                                           :doc_date,
                                                           :doc_begin_date,
                                                           :doc_end_date,
                                                           :customer,
                                                           :BIRTH_DATE,
                                                           :id_tariff,
                                                           :plan_ins_sum,
                                                           :plan_ins_tariff,
                                                           :plan_ins_pay,
                                                           :sum_pay,
                                                           :arch_num_str,
                                                           :reg_num_str,
                                                           :id_pay));


        result = result ||';
        ';
        --------------------------------------------------------------------------
        --- заполнение временной таблицы
        result =  result ||
                  'update t_temp_table set STR_FIELD1 = '''||:reg_num_str||''','||
                    'STR_FIELD4='''||:arch_num_str||''','||
                    'INT_FIELD4=(select d.id_doc '||
                      'from d_dt_document d inner join t_temp_table tt '||
                        'on d.reg_num starting with tt.str_field1 || ''-'' '||
                          'and d.id_state in (1, 3) '||
                          'and d.id_doc_source=3 '||
                      'where tt.int_field1='||:id_temp_key||
                        ' and tt.int_field2='||:id_pay||')'||
                  ' where INT_FIELD1=' || :id_temp_key ||
                      ' and INT_FIELD2=' ||:id_pay||';
        ';
        --------------------------------------------------------------------------
        --- автоматическая генерация операций
--        result =  result ||
--          'execute procedure XD_AUTO_GEN_OPERATION(
--            '||:id_pay||',
--            10/*ошиб-ск Го.МВД*/,
--            (select tt.int_field4 from t_temp_table tt
--              where tt.int_field1='||:id_temp_key||'
--                and tt.int_field2='||:id_pay||'
--             ),
--             null,
--             null);
--        ';
  
        suspend;
  
        counter = counter + 1;

        -- обработка архивного номера
        arch_tom_num_id = arch_tom_num_id + 1;
        if (arch_tom_num_id >= 1000) then
        begin
          arch_tom_num_id=1;
          arch_num_id = arch_num_id+1;
        end

        -- обработка пачек договоров
        if (counter = pachka_size) then
        begin
         counter = 0;
         result = '
                   /* delete from t_temp_table t where t.int_field1 = ' || :id_temp_key || '; */
                    commit;';
         suspend;
        end
      end

    -- обработка следующего пакета
    paketos = paketos + 1;
  end




         --   select * from d_dt_document d where d.reg_num = '111-10-05-99'
end^

SET TERM ; ^

COMMENT ON PROCEDURE XD_GENERATE_FULL IS
'[+] Генерация. Процедура генерации договоров по ГО.МВД из платежей (общая)';

/* Следующие операторы GRANT сгенерированы автоматически */

GRANT SELECT ON F_DT_PAYMENTS TO PROCEDURE XD_GENERATE_FULL;
GRANT SELECT ON F_DT_CASH_FLOW TO PROCEDURE XD_GENERATE_FULL;
GRANT SELECT ON T_TEMP_TABLE TO PROCEDURE XD_GENERATE_FULL;
GRANT SELECT ON SYS_OPTIONS TO PROCEDURE XD_GENERATE_FULL;
GRANT SELECT ON C_SP_NATURALS TO PROCEDURE XD_GENERATE_FULL;
GRANT SELECT ON D_DT_DOCUMENT TO PROCEDURE XD_GENERATE_FULL;
GRANT EXECUTE ON PROCEDURE XD_GENERATE TO PROCEDURE XD_GENERATE_FULL;

/* Существующие привилегии на эту процедуру */

GRANT EXECUTE ON PROCEDURE XD_GENERATE_FULL TO ONLINE_VUSO;
GRANT EXECUTE ON PROCEDURE XD_GENERATE_FULL TO PRISCHENKO;
GRANT EXECUTE ON PROCEDURE XD_GENERATE_FULL TO RUBTSOV;
GRANT EXECUTE ON PROCEDURE XD_GENERATE_FULL TO "_MTSBU";
GRANT EXECUTE ON PROCEDURE XD_GENERATE_FULL TO AGENT_ROLE;
GRANT EXECUTE ON PROCEDURE XD_GENERATE_FULL TO BACKUP;
GRANT EXECUTE ON PROCEDURE XD_GENERATE_FULL TO CIS_ROLE;
GRANT EXECUTE ON PROCEDURE XD_GENERATE_FULL TO NO_ROLE;
GRANT EXECUTE ON PROCEDURE XD_GENERATE_FULL TO ONLINE_ROLE;
GRANT EXECUTE ON PROCEDURE XD_GENERATE_FULL TO RDB$ADMIN;
GRANT EXECUTE ON PROCEDURE XD_GENERATE_FULL TO SERVICE_ROLE;
GRANT EXECUTE ON PROCEDURE XD_GENERATE_FULL TO WEB_ROLE;