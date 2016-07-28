/*
http://portal.vuso.ua/issues/130405

terminal7
D:\импорт\МЕД\Зачет Ска Ск

Параметры:
1) Дата операции                      - Дата операции 30.06.2016
2) Сумма операции                     - Сумма операции 7433,00 
3) Ключ временной таблицы             - 6464455
4) ID_DOC агентского договора         - 2555161
5) Сумма комиссии, удержанной агентом - 0
6) Описание операции                  - Привязка агентского платежа ВОГ РИТЕЙЛ от 29.06.2016 г. к активированным коробочным договорам страхования


Вопросы:
1) Дата операции - Какую дату ставить? Ставить дату, которой проводится генерация
6) Описание операции - Привязка агентского платежа ВОГ РИТЕЙЛ от 19.05.2016 г. к активированным коробочным договорам страхования  - Какую дату ставить? Ставить дату ту, которая в платеже (ИД платежа пришлет Шульга Ольга)

/**/



/************************************************************************************************
 *  Генерация операций типа Зачет Ск-а - Ск
 *
 *  Исходные данные в T_TEMP_TABLE
 *    INT_FIELD1 - ключ (6464455 по умолчанию)
 *    INT_FIELD2 - ID_DOC договора страхования (может быть NULL, тогда поиск по следующим полям)
 *    STR_FIELD1 - REG_NUM договора страхования
 *    DATE_FIELD1 - DATE_DOC договора страхования
 *    STR_FIELD2 - наименование (ФИО) страхователя
 *    CURR_FIELD1 - сумма платежа, которую нужно привязать к договору
 *  Параметры процедуры
 *    DATE_OPER - дата, которой генерируется операция
 *    SUM_OPER - сумма перезачёта
 *    ID_TEMP_KEY - ключ ко временной таблице, 6464455 по умолчанию
 *    ID_AG_DOC - ID_DOC агентского договора
 *    SUM_AG - сумма удержанного агентом комиссионного вознаграждения (может быть NULL)
 *      должно выполняться равенство: SUM(T_TEMP_TABLE.CURR_FIELD1) = SUP_OPER + coalesce(SUM_AG, 0)
 *    DESCR - описание операции
 *  Возвращаемые значения
 *    ID_OPER - если всё хорошо, NULL - есть ошибки
 */
execute block(
  date_oper tdate = :"Дата операции",
  sum_oper tmoney = :"Сумма операции",
  id_temp_key tinteger = :"Ключ временной таблицы (6464455)",
  id_doc_ag tinteger = :"ID_DOC агентского договора",
  sum_ag tmoney = :"Сумма комиссии, удержанной агентом",
  descr tvarchar400 = :"Описание операции" 
) returns (id_oper tinteger)
as
  declare variable tmp_cnt tinteger;
  declare variable tmp_sum tmoney;
  declare variable reg_num tvarchar40;
  declare variable date_doc tdate;
  declare variable id_doc tinteger;
  declare variable id_customer tinteger;
  declare variable list_ids tvarchar810;
begin
  -- Проверка входных параметров
  if (:date_oper is null or :sum_oper is null or :id_doc_ag is null) then
    exception s_exception 'Дата операции, сумма операции и ID_DOC агентского договора должны быть заданы (NOT NULL)';
  if (:id_temp_key is null) then
    id_temp_key = 6464455;
  if (:sum_ag is null) then
    sum_ag = 0;
  if (:sum_oper <= 0 or :sum_ag < 0) then
    exception s_exception 'Сумма операции должна быть положительной, сумма комиссии не может быть отрицательной';

  select cc.id_customer
  from d_dt_document d
    inner join d_dt_contract_customers cc
      on cc.id_contract_customer = d.id_contract_customer
  where d.id_doc = :id_doc_ag
    and d.id_state in (2, 3)
    and d.id_doc_type = 1
  into :id_customer;
  if (:id_customer is null) then
    exception s_exception 'Подписанный или утверждённый агентский договор не найден, ID_DOC = ' || :id_doc_ag;

  -- Проверка исходных данных во временной таблице
  select count(*), sum(t.curr_field1)
  from t_temp_table t
  where t.int_field1 = :id_temp_key 
  into :tmp_cnt, :tmp_sum;

  if (:tmp_cnt = 0 or :tmp_sum is null) then
    exception s_exception 'Нет данных по договорам страхования в T_TEMP_TABLE по ключу ' || :id_temp_key;
  if (exists (select * from t_temp_table where int_field1 = :id_temp_key and (curr_field1 is null or curr_field1 = 0))) then
    exception s_exception 'Сумма операции по любому из договоров страхования не может быть NULL или 0.00';
  if (:tmp_sum <> :sum_oper + :sum_ag) then
    exception s_exception 'Сумма по договорам страхования (' || :tmp_sum || ') не сходится с суммой операции (' || (:sum_oper + :sum_ag) || ')';
  if (exists (
      select t.str_field1, t.date_field1
      from t_temp_table t
      where t.int_field1 = :id_temp_key
      group by 1, 2
      having count(*) > 1
    )
  ) then
  begin
    select t.str_field1, t.date_field1
    from t_temp_table t
    where t.int_field1 = :id_temp_key
    group by 1, 2
    having count(*) > 1
    rows 1
    into :reg_num, :date_doc;

    exception s_exception 'Запрещается дублирование договоров страхования в реестре, ' || reg_num;
  end

  -- Заполнение ID_DOC
  for
    select t.str_field1, t.date_field1, t.curr_field1
    from t_temp_table t
    where t.int_field1 = :id_temp_key 
      and t.int_field2 is null
    into :reg_num, :date_doc, :tmp_sum
  do
  begin
    select min(d.id_doc), count(*)
    from d_dt_document d
    where d.reg_num = :reg_num
      and d.date_doc = :date_doc
      and d.id_state in (1, 2, 3)
    into :id_doc, :tmp_cnt;

    if (:tmp_cnt = 0) then
      exception s_exception 'Не найден ID_DOC для договора ' || :reg_num || ', платёж ' || :tmp_sum;
    else if (:tmp_cnt > 1) then
      exception s_exception 'Для договора ' || :reg_num || ', платёж ' || :tmp_sum || ' найдено несколько (' || :tmp_cnt || ') соответствий!';
    else
      update t_temp_table t
      set t.int_field2 = :id_doc
      where t.int_field1 = :id_temp_key
        and t.str_field1 = :reg_num
        and t.date_field1 = :date_doc;
  end 

  -- Проверка корректности договоров
  select list(t.int_field2)
  from t_temp_table t
    left join d_dt_document d
      on d.id_doc = t.int_field2
    left join d_dt_insurance di
      on di.id_doc = d.id_doc
  where t.int_field1 = :id_temp_key
    and (d.id_doc is null
      or di.id_doc is null
      or d.id_state not in (2, 3)
      or d.id_doc_inure_type = 8
      or di.sum_doc < t.curr_field1
      or d.date_doc > :date_oper
    )
  into :list_ids;

  if (:list_ids is not null) then
    exception s_exception 'Следующие договоры не найдены, не являются договором страхования, заключены позже даты операции
'     || 'не находятся в состоянии "Подписан" или "Утверждён" или имеют тип вступления "По генеральному договору".
'     || 'ID_DOC in (' || :list_ids || ')';

  -- Описание операции
  if (:descr is null) then
    select 'Привязка агентского платежа ' ||
      trim(iif(position('(' in c.search_name) > 0, left(c.search_name, position('(' in c.search_name) - 1), c.search_name)) ||
      ' (договор ' || d.reg_num || ') ' ||
      'от ' || lpad(extract(day from :date_oper),2,'0') || '.'
            || lpad(extract(month from :date_oper),2,'0') || '.'
            || lpad(extract(year from :date_oper),4,'0')|| ' г. ' ||
      'в сумме ' || :sum_oper || ' грн. к договорам страхования ' ||
      coalesce( (
          select list(distinct ik.short_name_ins_kind)
          from t_temp_table t
            inner join d_dt_insurance di
              on di.id_doc = t.int_field2 
            inner join b_sp_ins_kind ik
              on ik.id_ins_kind = di.id_ins_kind 
          where t.int_field1 = :id_temp_key
        ), ''
      )
    from d_dt_document d
      inner join d_dt_contract_customers cc
        on cc.id_contract_customer = d.id_contract_customer
      inner join c_sp_customers c
        on c.id_customer = cc.id_customer
    where d.id_doc = :id_doc_ag
    into :descr;

  --exception s_exception :descr;

  -- Генерация операции
  select id_operation
  from f_up_dt_operations(1, gen_id(gen_f_dt_operations, 1), 12,
    1/*черновик*/, :date_oper, :date_oper, :sum_oper + :sum_ag, :descr,
    null, null, null, null, null, null, null, 1)
  into :id_oper;

  -- Добавляем "сторно" оригинального платежа
  select null
  from f_up_dt_offset_deals(1, gen_id(gen_f_up_dt_offset_deal_id, 1), :date_oper,
    :sum_oper, :id_customer, 138 /* Ск-а */, :id_doc_ag, null,
    :id_oper, null, 2/* списание */, null, null, null, 1)
  into :tmp_cnt;

  -- Добавляем выплату комиссии
  if (:sum_ag > 0) then
    select null
    from f_up_dt_offset_deals(1, gen_id(gen_f_up_dt_offset_deal_id, 1), :date_oper,
      :sum_ag, :id_customer, 32 /* Ав */, :id_doc_ag, null,
      :id_oper, null, 2/* списание */, null, null, null, null)
    into :tmp_cnt;

  -- Добавляем платежи на договоры страхования
  for
    select d.id_doc, cc.id_customer, t.curr_field1
    from t_temp_table t
      inner join d_dt_document d
        on d.id_doc = t.int_field2
      inner join d_dt_contract_customers cc
        on cc.id_contract_customer = d.id_contract_customer
    where t.int_field1 = :id_temp_key
    into :id_doc, :id_customer, :tmp_sum
  do
    select null
    from f_up_dt_offset_deals(1, gen_id(gen_f_up_dt_offset_deal_id, 1), :date_oper,
      :tmp_sum, :id_customer, 26 /* Ск */, :id_doc, null,
      :id_oper, null, 1/* поступление */, null, null, null, null)
    into :tmp_cnt;

  -- Подписываем операцию
  update f_dt_operations op
  set op.id_state_operation = 2
  where op.id_operation = :id_oper; /**/

  -- Конец
  suspend;
end