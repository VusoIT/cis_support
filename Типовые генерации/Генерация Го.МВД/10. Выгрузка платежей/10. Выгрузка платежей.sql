--http://portal.vuso.ua/issues/127289
--Генерация Го.МВД. Описание алгоритма
/*
10. Выгрузка платежей
Если договоры привязывались непосредственно к платежам из выписки, то, скорее всего, ничего дополнительно делать не нужно.
Если же генерировались операции, то необходимо будет пометить на выгрузку перезачёты
*/
execute block returns (id_data_set tinteger)
as
  declare variable id_pay tinteger;
  declare variable cnt tinteger;
begin
  cnt = 0;
  id_data_set = null;
  for
    select distinct op.id_pay_abstract--, t.int_field5--, count(*)--, eh.id_export_state
    from t_temp_table t
      inner join f_dt_operations op
        on op.id_operation = t.int_field5
      --left join x_dt_export_history eh
      --  on eh.id_object = op.id_pay_abstract
      --    and eh.id_object_type = 13
       --   and eh.actual_record = 1
    where t.int_field1 = 999
    into :id_pay
  do
    if (:id_pay is not null) then
    begin
      if (:cnt >= 10 or :id_data_set is null) then
      begin
        insert into X_DT_DATA_SETS (ID_DATA_SET, ID_EXTERNAL_SYSTEM, DESCRIPTION, DATE_BEG, DATE_END, ID_DATA_SET_TYPE)
        values (gen_id(gen_x_dt_data_sets_id, 1), 1, 'служебный', current_date, current_date, 2)
        returning id_data_set
        into :id_data_set;

        cnt = 0;
        suspend;
      end

      select xdt.id_export_history
      from x_up_dt_export_history(
                          1, gen_id(gen_x_dt_export_history_id, 1), null, 13,
                          :id_pay, 0, current_timestamp,
                          current_timestamp, 47 /*ИД пользователя, который поставил объект на выгрузку*/,
                          :id_data_set /*ИД служебного набора*/, null, null, null, null, null,
                          null, null, null, null, null, null, null, null, null, null, null,
                          null, null, null, null, null, null, null, null, null, null, null,
                          null, null, null, null, null,  null) xdt
      into :id_pay;
      cnt = :cnt + 1;
    end
end
/*
Перезачёты группируются по 10 в служебные наборы данных. Далее каждый из наборов нужно будет выгрузить вручную (см.Приложение 1)
*/


/*
ID_DATA_SET
+-1071030
-1071031
/**/