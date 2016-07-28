--http://portal.vuso.ua/issues/127289
--Генерация Го.МВД. Описание алгоритма

--1) Узнаем первый номер бланка (значение генератора + 1)
--select gen_id(gen_b_dt_blanks_number, 0) + 1 from rdb$database

--2) Смещаем генератор на количество бланков
--select gen_id(gen_b_dt_blanks_number, 1587) from rdb$database


--Вот "общий" запрос:
select 1 as "N", 'Первый' as "Порядок", gen_id(GEN_B_DT_BLANKS_NUMBER, 0) + 1 as "Номер бланка" from RDB$DATABASE
union all
select 2 as "N", 'Последний' as "Порядок", gen_id(GEN_B_DT_BLANKS_NUMBER, 1587) as "Номер бланка" from RDB$DATABASE


--Далее следует создать эти бланки в КИС. Лента Договоры - Реестр бланков, кнопка Добавить... 
--1)Тип бланка - Договор страхования,
--2)Серия - пусто,
--3)С и По - результат запроса (выше),
--4)Дата состояния - первое число периода генерации,
--5)Стоимость - 0,
--6)Ответственный - Евдокименко Владимир Владимирович (ID_CUSTOMER=595480),
--7)подразделение - Го.МВД (ID=1497)

--За архивными номерами следует обратиться в договорной отдел, к Коряковская Наталия. 
--Архивный номер состоит из трех групп цифр ГГ-ТТТ/ННН, где
--ГГ - номер года, когда были заключены включённые в архивный том договоры страхования
--ТТТ - номер архивного тома, по-порядку с начала года
--ННН - номер внутри архивного тома, в общем случае меняется от 001 до 999
--Таким образом, в один архивный том можно поместить до 999 договоров. У договорного отдела заказываются номера архивных томов (посчитать, сколько нужно, отталкиваясь от объема генерации)


--Генерацию номеров и создание пула бланков можно автоматизировать.
--B_UP_DT_BLANKS - эта процедура добавляет бланки в КИС ? 



--------Мой автоматический скрипт

--Внимание! Поле BLANK_STRING, просто заполняется номером бланка, без дополнительных нулей слева.
--Т-е, бланк № 123456, так туда и запишется, а не 012345. Пока бланки 7-ми значные, это не актуально.
--Поле NUMBER_STRING заполняет триггер B_DT_BLANKS_BIU_FIELD_FILLING перед обновлением и вставкой
execute block (
    BLANK_COUNT integer = :"Количество договоров для генерации",
    STATE_DATE date = :"первое число периода генерации"
    --SELECT dateadd(DAY, -EXTRACT(DAY FROM CURRENT_DATE)+1, CURRENT_date) FROM rdb$database;
)
returns (
    BLANK_BEGIN integer,
    BLANK_END integer)
as
declare variable ID_USER integer; --ИД пользователя
declare variable BLANK_CUR_INT integer; --Текущий бланк
declare variable BLANK_CUR_STR varchar(7); --Текущий бланк (строка)

begin

  --Инициализация -----
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


  while (BLANK_CUR_INT < BLANK_END + 1) do
  begin
   BLANK_CUR_STR = BLANK_CUR_INT;
    insert into B_DT_BLANKS (ID_BLANK, ID_TYPE, SERIES, NUMBER, ID_BLANK_STATE, ID_RESPONSIBLE, ID_STATE_RESPONSIBLE,
                             STATE_PERIOD, ID_CONTRACT, ID_HOLD_CUSTOMER, ID_HOLD_AGENT, ID_HOLD_DEPARTMENT, NOTE,
                             ID_ACT, RESERVE_ID_ACT, IS_EXPORTED_MTSBU, BLANK_STRING, ID_RESP_CUSTOMER,
                             ID_RESP_DEPARTMENT, ID_RESP_AGENT, ID_OPERATOR, BLANK_COST, ID_VETO_CUSTOMER, IS_VIRTUAL,
                             IS_NUMDOC, ID_DOC_TYPE, NUMBER_STRING)
    values (gen_id(GEN_B_DT_BLANKS, 1), 3, '', :BLANK_CUR_INT, 0, null, null, :STATE_DATE, null, 595480, null, 1497,
            null, null, null, null, :BLANK_CUR_STR, 595480, 1497, null, :ID_USER, 0, null, 0, 1, null, null);
 
 BLANK_CUR_INT = BLANK_CUR_INT + 1;

  end

  suspend;

end