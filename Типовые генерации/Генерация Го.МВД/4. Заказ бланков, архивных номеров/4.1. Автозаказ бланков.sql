--Скрипт для автоматической генерации необходимого количества бланков Го.МВД в КИС

/*
Внимание! Поле BLANK_STRING, просто заполняется номером бланка, без дополнительных нулей слева.
Например: бланк № 123456, так туда и запишется, а не 012345. Пока бланки 7-ми значные, это не актуально.
Поле NUMBER_STRING заполняет триггер B_DT_BLANKS_BIU_FIELD_FILLING перед обновлением и вставкой
*/
execute block (
    BLANK_COUNT integer = :"Количество договоров для генерации",
    STATE_DATE date = :"Первое число периода генерации")
returns (
    BLANK_BEGIN integer,
    BLANK_END integer)
as
declare variable ID_USER integer; --ИД пользователя
declare variable BLANK_CUR_INT integer; --Текущий бланк
declare variable BLANK_CUR_STR varchar(7); --Текущий бланк (строка)

declare ID_RESP_DEP integer; --подразделение - Го.МВД (ID=1497)
declare ID_RESP_CUST integer; --Ответственный - Евдокименко Владимир Владимирович (ID_CUSTOMER=595480)

begin

  --Инициализация (ручная)-----
  --подразделение - Го.МВД (ID=1497)
  ID_RESP_DEP = 1497;

  --Ответственный - Евдокименко Владимир Владимирович (ID_CUSTOMER=595480)
  ID_RESP_CUST = 595480;

  --Инициализация (авто)-----
  --Текущий пользователь
  select RDB$GET_CONTEXT('USER_SESSION', 'CURRENT_CUSTOMER_ID')
  from RDB$DATABASE
  into :ID_USER;

  --Первый номер бланка
  select gen_id(GEN_B_DT_BLANKS_NUMBER, 0) + 1
  from RDB$DATABASE
  into :BLANK_BEGIN;

  --Последний номер бланка
  select gen_id(GEN_B_DT_BLANKS_NUMBER, :BLANK_COUNT)
  from RDB$DATABASE
  into :BLANK_END;

  BLANK_CUR_INT = BLANK_BEGIN;

  --Цикл вставки бланков
  while (BLANK_CUR_INT < BLANK_END + 1) do


  begin

    BLANK_CUR_STR = BLANK_CUR_INT;

    insert into B_DT_BLANKS (ID_BLANK, ID_TYPE, SERIES, NUMBER, ID_BLANK_STATE, ID_RESPONSIBLE, ID_STATE_RESPONSIBLE,
                             STATE_PERIOD, ID_CONTRACT, ID_HOLD_CUSTOMER, ID_HOLD_AGENT, ID_HOLD_DEPARTMENT, NOTE,
                             ID_ACT, RESERVE_ID_ACT, IS_EXPORTED_MTSBU, BLANK_STRING, ID_RESP_CUSTOMER,
                             ID_RESP_DEPARTMENT, ID_RESP_AGENT, ID_OPERATOR, BLANK_COST, ID_VETO_CUSTOMER, IS_VIRTUAL,
                             IS_NUMDOC, ID_DOC_TYPE, NUMBER_STRING)
    values (gen_id(GEN_B_DT_BLANKS, 1), 3, '', :BLANK_CUR_INT, 0, null, null, :STATE_DATE, null, :ID_RESP_CUST, null,
            :ID_RESP_DEP, null, null, null, null, :BLANK_CUR_STR, :ID_RESP_CUST, :ID_RESP_DEP, null, :ID_USER, 0, null,
            0, 1, null, null);

    BLANK_CUR_INT = BLANK_CUR_INT + 1;

  end

  suspend;

end