--http://portal.vuso.ua/issues/127289
--Генерация Го.МВД. Описание алгоритма

--9. Выгрузка договоров (возможно, с установкой других дат)

--Заполнить "другие даты" 

execute block
as
  declare variable id_doc tinteger;
  declare variable date_doc tdate;
  declare variable end_doc tdate;
  declare variable open_period tdate;
begin
  open_period = date '01.03.2016';
  -- Отключение контекстных переменных
  select rdb$set_context('USER_SESSION', 'EXPORT_IGNORE', 1) from rdb$database into :id_doc;
  select rdb$set_context('USER_SESSION', 'CRM_IGNORE', 1) from rdb$database into :id_doc;
  select rdb$set_context('USER_SESSION', 'EXPORT_PERIOD', 1) from rdb$database into :id_doc; /**/

  for
    select d.id_doc, d.date_doc, d.end_date_doc
    from d_dt_document d
      inner join t_temp_table t
        on t.int_field4 = d.id_doc
      inner join d_dt_insurance di
        on di.id_doc = d.id_doc
    where t.int_field1 = 999
      and d.date_doc between date '01.01.2016' and date '31.03.2016'
    into :id_doc, :date_doc, :end_doc
  do
    update d_dt_document d
    set d.is_other_innure = 1,
      d.other_date_doc = maxvalue(:date_doc, :open_period),
      d.other_inure_date_doc = maxvalue(:date_doc, :open_period),
      d.other_end_date_doc = maxvalue(:end_doc, :open_period)
    where d.id_doc = :id_doc;  /**/

  -- Отключение контекстных переменных
  select rdb$set_context('USER_SESSION', 'EXPORT_IGNORE', null) from rdb$database into :id_doc;
  select rdb$set_context('USER_SESSION', 'CRM_IGNORE', null) from rdb$database into :id_doc;
  select rdb$set_context('USER_SESSION', 'EXPORT_PERIOD', null) from rdb$database into :id_doc;  /**/
end

--Обращаю внимание, что пометка на автоматическую выгрузку в скрипте отключается!

---------------------------------------------------------------------------------------------------------------

--Пометить на выгрузку договоры

execute block
returns (id_data_set tinteger)
as
  declare variable id_doc tinteger;
  declare variable id_pay tinteger;
  declare variable cnt tinteger;
begin
  cnt = 2000;

  for
    select t.int_field2, t.int_field4-- eh.id_data_set, eh.id_export_state, count(*)
    from t_temp_table t
      left join x_dt_export_history eh
        on eh.id_object = t.int_field4
          and eh.id_object_type = 10
          and eh.actual_record = 1
    where t.int_field1 = 999
      and t.int_field4 is not null
      and eh.id_export_state is null
    into :id_pay, :id_doc
  do
    if (:id_doc is not null) then
    begin
      if (:cnt >= 2000 or :id_data_set is null) then
      begin
        insert into X_DT_DATA_SETS (ID_DATA_SET, ID_EXTERNAL_SYSTEM, DESCRIPTION, DATE_BEG, DATE_END, ID_DATA_SET_TYPE)
        values (gen_id(gen_x_dt_data_sets_id, 1), 1, 'служебный', current_date, current_date, 2)
        returning id_data_set
        into :id_data_set;

        suspend;

        cnt = 0;
      end

      select xdt.id_export_history
      from x_up_dt_export_history(
              1, gen_id(gen_x_dt_export_history_id, 1), null, 10,
              :id_doc, 0, current_timestamp,
              current_timestamp, 47 /*ИД пользователя, который поставил объект на выгрузку*/,
              :id_data_set /*ИД служебного набора*/, null, null, null, null, null,
              null, null, null, null, null, null, null, null, null, null, null,
              null, null, null, null, null, null, null, null, null, null, null,
              null, null, null, null, null,  null) xdt
      into :id_pay;
      cnt = :cnt + 1;
    end
end

--Договоры группируются по 2000 в служебные наборы данных. Если больше, шедулер может обвалиться с ошибкой Out of memory error при выгрузке.
--Далее каждый из наборов данных нужно будет выгрузить, запустив шедулер вручную (см.Приложение 1).



/*

+-1070853    -У меня
+-1070854   -terminal.vuso.ua:3384
+-1070855   -terminal.vuso.ua:3399
+-1070856   -cis_old
-1070857   -У меня
+-1070858    -terminal.vuso.ua:3384

/**/