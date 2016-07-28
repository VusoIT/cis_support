/*

Создание записей в F_PAY_ABSTRACTS и привязка операций

Работа со скриптом.
1. Отключаем триггер - F_DT_OPERATIONS_BU0. Можно ли это делать???!!!!!!!
2. Устанавливаем дату ABSTRACT_DATE

--Ответ Бондаренко
Да. Нужно создать записи в таблице F_PAY_ABSTRACT (перезачёты) и добавить на них ссылки из операций. Операции лучше группировать по 500..1000, не больше. У перезачётов должны быть заполены ID_ABSTRACT, ABSTRACT_DATE = 31/12/2015 и ID_TYPE_ABSTRACT = 1

--Алгоритм
1. Создаем запись в F_PAY_ABSTRACTS
INSERT INTO F_PAY_ABSTRACTS (ID_ABSTRACT, ABSTRACT_DATE, ID_TYPE_ABSTRACT) VALUES (gen_id(GEN_F_PAY_ABSTRACTS_ID, 1), '31.12.2015', 1); 

2. В цикле, по таблице T_TEMP_TABLE отбираем по одному и апдейтим ИД-шником новой записи в F_PAY_ABSTRACTS 


/**/



execute block
--returns(ID_OPERATION TINTEGER, ID_ABSTRACT bigint)

as
declare variable ID_OPERATION TINTEGER;
declare variable CNT TINTEGER;
declare variable ABSTRACT_DATE date;
declare variable ID_ABSTRACT bigint;
declare variable id_doc integer;
begin


   -- Отключение контекстных переменных
  select rdb$set_context('USER_SESSION', 'EXPORT_IGNORE', 1) from rdb$database into :id_doc;
  select rdb$set_context('USER_SESSION', 'CRM_IGNORE', 1) from rdb$database into :id_doc;
  select rdb$set_context('USER_SESSION', 'EXPORT_PERIOD', 1) from rdb$database into :id_doc;
  /**/
  ABSTRACT_DATE = '31.03.2016';

  CNT = 0;

    ID_ABSTRACT = gen_id(GEN_F_PAY_ABSTRACTS_ID, 1);
    insert into F_PAY_ABSTRACTS (ID_ABSTRACT, ABSTRACT_DATE, ID_TYPE_ABSTRACT)
    values (:ID_ABSTRACT, :ABSTRACT_DATE, 1);


  for select T.INT_FIELD5
      from T_TEMP_TABLE T
      where T.INT_FIELD1 = 999
      into :ID_OPERATION
  do
  begin

    --Сбрасываем счетчик и создаем новую выписку

    if (:CNT = 1000) then
    begin
    CNT = 0;

    ID_ABSTRACT = gen_id(GEN_F_PAY_ABSTRACTS_ID, 1);
    insert into F_PAY_ABSTRACTS (ID_ABSTRACT, ABSTRACT_DATE, ID_TYPE_ABSTRACT)
    values (:ID_ABSTRACT, :ABSTRACT_DATE, 1);


    end
    --Сбрасываем счетчик и создаем новую выписку (конец)

    update F_DT_OPERATIONS OP
    set OP.ID_PAY_ABSTRACT = :ID_ABSTRACT,
        OP.IS_UPLOAD_EXTERNAL_SYSTEM = 1
    where OP.ID_OPERATION = :ID_OPERATION;

    CNT = :CNT + 1;

    --suspend;
  end
    -- Включение контекстных переменных
  select rdb$set_context('USER_SESSION', 'EXPORT_IGNORE', null) from rdb$database into :id_doc;
  select rdb$set_context('USER_SESSION', 'CRM_IGNORE', null) from rdb$database into :id_doc;
  select rdb$set_context('USER_SESSION', 'EXPORT_PERIOD', null) from rdb$database into :id_doc;
  /**/
end



/*
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

/**/

--INSERT INTO F_PAY_ABSTRACTS (ID_ABSTRACT, ABSTRACT_DATE, ID_TYPE_ABSTRACT) VALUES (gen_id(GEN_F_PAY_ABSTRACTS_ID, 1), '31.12.2015', 1); 