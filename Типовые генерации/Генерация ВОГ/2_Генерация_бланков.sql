/*
Генерация ВОГ
2_Генерация_бланков
Мельников Т.В. 04.06.2016
/**/

execute block as
declare variable TEMP_KEY integer; --Ключ временной таблицы
declare variable ID_NUMBER integer; --Виртуальный ID записей
declare variable ID_BLANK TINTEGER; --ID бланка
declare variable BLANK_NUMBER TINTEGER; --Номер бланка
declare variable STATE_PERIOD date; --дата изменения состояния бланка
declare variable ID_RESP_CUSTOMER TINTEGER; --Ответственное лицо
declare variable ID_RESP_DEPARTMENT TINTEGER; --Ответственное подразделение
declare variable ID_HOLD_AGENT TINTEGER; --Материально ответственный агент
declare variable ID_USER TINTEGER;
declare variable ID_USER_CUSTOMER TINTEGER;

begin
  --Настройки
  TEMP_KEY      = 4240;          --Ключ временной таблицы
  STATE_PERIOD  = '01.XX.201X';  --Начало периода генерации
  
  
  --Константы
  ID_RESP_CUSTOMER = 356040;-- Ответственное лицо (Кабанец Ольга Юрьевна)
  ID_RESP_DEPARTMENT = 96;--Ответственное подразделение (Го)
  ID_HOLD_AGENT = 2518680;--Материально ответственный агент (6450 )

  --Получение текущего пользователя
  select au.id_user, au.id_customer from a_user au where au.login = current_user
  --select RDB$GET_CONTEXT('USER_SESSION', 'CURRENT_USER_ID'), AU.ID_CUSTOMER
  --from RDB$DATABASE
  --join A_USER AU on AU.ID_USER = RDB$GET_CONTEXT('USER_SESSION', 'CURRENT_USER_ID')
  into :ID_USER, :ID_USER_CUSTOMER;

  --Генерация бланков
  for select TT.INT_FIELD2 as ID_NUMBER
      from T_TEMP_TABLE TT
      where TT.INT_FIELD1 = :TEMP_KEY
	  and TT.INT_FIELD3 is null
      order by TT.INT_FIELD2
      into :ID_NUMBER
  do
  begin

    -- Генерация бланка
    BLANK_NUMBER = gen_id(GEN_B_DT_BLANKS_NUMBER, 1);
    ID_BLANK = gen_id(GEN_B_DT_BLANKS, 1);

    insert into B_DT_BLANKS (ID_BLANK, ID_TYPE, SERIES, NUMBER, ID_BLANK_STATE, STATE_PERIOD, ID_HOLD_AGENT,
                             ID_HOLD_DEPARTMENT, BLANK_STRING, ID_RESP_CUSTOMER, ID_RESP_DEPARTMENT, ID_OPERATOR,
                             IS_VIRTUAL, IS_NUMDOC, BLANK_COST)
    values (:ID_BLANK, 3, '', :BLANK_NUMBER, 0, :STATE_PERIOD, :ID_HOLD_AGENT, :ID_RESP_DEPARTMENT, :BLANK_NUMBER,
            :ID_RESP_CUSTOMER, :ID_RESP_DEPARTMENT, :ID_USER_CUSTOMER, 1, 1, 0.00);

    --Обновление временной таблицы
    update T_TEMP_TABLE TT
    set TT.INT_FIELD3 = :ID_BLANK
    where TT.INT_FIELD1 = :TEMP_KEY and
          TT.INT_FIELD2 = :ID_NUMBER;

  end

end

/* --Проверка
select
--TT.INT_FIELD1 as TEMP_KEY,
TT.INT_FIELD2 as ID_NUMBER,
TT.INT_FIELD3 as ID_BLANK,
TT.CURR_FIELD1
from T_TEMP_TABLE TT
where TT.INT_FIELD1 = 4240
order by TT.INT_FIELD2  
/**/ 