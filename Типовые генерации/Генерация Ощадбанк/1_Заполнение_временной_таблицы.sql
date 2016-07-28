/*
Генерация Ощадбанк
Заполнение временной таблицы
Мельников Т.В. 31.05.2016
/**/

execute block as
declare variable TEMP_KEY integer; --Ключ временной таблицы

--Переменные таблиц платежей - f_dt_payments и f_dt_cash_flow
declare variable ID_PAYMENT tinteger;
declare variable ID_CASH_FLOW tinteger;
--declare variable cf_descr TVARCHAR400;   --T_TEMP_TABLE - TVARCHAR1000;
declare variable FACT_SUM TVARCHAR400;   --T_TEMP_TABLE - TMONEY;
declare variable cf_date TDATE;          --T_TEMP_TABLE - TDATETIME;

--Переменые для парсинга назначения
declare variable CASHIER_NUMBER varchar(100);      --1 Табельный номер кассира;
declare variable CASHIER_PHONE varchar(100);       --2 Мобильный номер кассира;
declare variable INSURANCE_TYPE varchar(100);      --3 код вида страхования;
declare variable CLIENT_FIO varchar(100);          --4 ФИО клиента;
declare variable AUTO_VIN varchar(100);            --5 VIN кузова;
declare variable CLIENT_PHONE varchar(100);        --6 Телефон клиента;
declare variable CLIENT_INN  varchar(100);         --7 ИНН клиента;
declare variable CONTRACT_ENTRY_DATE tdate;-- varchar(100); --8 Дата вступления договора в силу;
declare variable BANK_CODE varchar(100);           --9 код РУ Банка/Код ТВБВ;
declare variable AUTO_PLACE varchar(100);          --10 Место регистрации;
declare variable AUTO_NUMBER varchar(100);         --11 Гос номер автомобиля;
declare variable AUTO_MARK varchar(100);           --12 Марка модель

--Переменные парсинга ФИО
declare variable last_name varchar(1000);          --Фамилия
declare variable first_name varchar(1000);         --Имя
declare variable patronimic_name varchar(1000);    --Отчество 

declare variable ID_CUSTOMER_TYPE T_INTEGER;       --тип контрагента (1 - физическое лицо, 2 - юр.лицо)
declare variable PURP_OF_PAY varchar(260);  --Назначение платежа
declare variable DELIMITER varchar(1);      --Разделитель ";"
declare variable POSITION_FROM integer;
declare variable POSITION_TO integer;
declare variable BLOCK_NUMB integer;
declare variable ERRORS  varchar(1000); --Список ошибок
declare variable NOTE varchar(1000); --Примечание

begin

  --Настройки
  TEMP_KEY = 4240;
  DELIMITER = ';';

  --Очистка временной таблицы по ключу
  delete from T_TEMP_TABLE TT where TT.INT_FIELD1 = :TEMP_KEY;

  for select
        --t.int_field1 as ID_KEY,
        t.int_field2  as ID_PAYMENT,   --Виртуальное поле ID_PAYMENT из f_dt_payments
        t.int_field3  as ID_CASH_FLOW, --Виртуальное поле ID_CASH_FLOW из f_dt_cash_flow
        t.str_field1  as cf_descr,     --Виртуальное поле "Назначение" из f_dt_cash_flow
        t.CURR_FIELD1 as FACT_SUM,     --Виртуальное поле "Фактическая сумма платежа (разнесенная)" из f_dt_payments
        t.DATE_FIELD1 as cf_date       --Виртуальное поле "Дата движения денежных средств" из f_dt_cash_flow
     from T_TEMP_TABLE t where t.INT_FIELD1 = 4030
     into :ID_PAYMENT, :ID_CASH_FLOW, :PURP_OF_PAY, /*:cf_descr,*/ :FACT_SUM, :cf_date 
  do begin
  
  --Инициализация переменных
  ID_CUSTOMER_TYPE = 0;
  ERRORS = '';
  --PURP_OF_PAY = cf_descr;
  POSITION_FROM = 0;
  POSITION_TO = 1;
  BLOCK_NUMB = 1;
  LAST_NAME = '';
  FIRST_NAME = '';
  PATRONIMIC_NAME = '';
  NOTE = 'ID платежа - '||:ID_PAYMENT||', назначение - '||:PURP_OF_PAY;
  
--Распознание типа контрагента
--ЮР
  if (:FACT_SUM in (1078.27, 561.60, 763.78, 628.99, 494.21, 336.96, 673.92, 1229.23, 640.22, 870.70, 717.05, 563.40, 384.13, 768.27, 1272.36, 662.69, 901.26, 742.21, 583.17, 397.61, 795.23, 1962.46, 1022.11, 1390.07, 1144.77, 899.46, 613.27, 1226.53, 282.01, 146.88, 199.76, 164.51, 129.25, 88.13, 176.26, 1480.55, 771.12, 1048.72, 863.65, 678.59, 462.67, 925.34, 1741.82, 907.20, 1233.79, 1016.06, 798.34, 544.32, 1088.64, 1658.88, 864.00, 1175.04, 967.68, 760.32, 518.40, 1071.36, 1808.18, 941.76, 1280.79, 1054.77, 828.75, 565.06, 1130.11, 414.72, 216.00, 293.76, 241.92, 190.08, 129.60, 259.20, 366.61, 190.94, 259.68, 213.86, 168.03, 114.57, 229.13, 733.22, 381.89, 519.37, 427.71, 336.06, 229.13, 458.27)
) then begin
ID_CUSTOMER_TYPE = 2;
end
--ФИЗ
  if (:FACT_SUM in (556.42, 270.00, 367.20, 302.40, 237.60, 162.00, 347.76, 590.98, 307.80, 418.61, 344.74, 270.86, 184.68, 396.45, 611.71, 318.60, 433.30, 356.83, 280.37, 191.16, 410.36, 1036.80, 540.00, 734.40, 604.80, 475.20, 324.00, 691.20, 1181.95, 615.60, 837.22, 689.47, 541.73, 369.36, 738.72, 1223.42, 637.20, 866.59, 713.66, 560.74, 382.32, 764.64, 1886.98, 982.80, 1336.61, 1100.74, 864.86, 589.68, 1179.36, 352.51, 183.60, 249.70, 205.63, 161.57, 110.16, 220.32, 1850.69, 963.90, 1310.90, 1079.57, 848.23, 578.34, 1156.68, 2177.28, 1134.00, 1542.24, 1270.08, 997.92, 680.40, 1360.80, 2073.60, 1080.00, 1468.80, 1209.60, 950.40, 648.00, 1382.40, 2260.22, 1177.20, 1600.99, 1318.46, 1035.94, 706.32, 1412.64, 552.96, 288.00, 391.68, 322.56, 253.44, 172.80, 345.60, 376.01, 195.84, 266.34, 219.34, 172.34, 117.50, 235.01, 705.02, 403.92, 499.39, 411.26, 323.14, 242.35, 440.64)
) then begin
ID_CUSTOMER_TYPE = 1;
end
if(ID_CUSTOMER_TYPE = 0)then begin
      ERRORS = ERRORS || ' /Не определен тип по сумме!';
end

    --Парсинг назначения платежа
    WHILE(POSITION_FROM < char_length(PURP_OF_PAY)) DO
    BEGIN
     if (SUBSTRING(PURP_OF_PAY FROM POSITION_TO FOR 1 ) = DELIMITER or POSITION_TO = char_length(PURP_OF_PAY))  then begin
       --Корректируем последний
       if (POSITION_TO = char_length(PURP_OF_PAY)) then POSITION_TO = POSITION_TO + 1;
       if (BLOCK_NUMB = 1)  then  CASHIER_NUMBER = trim(SUBSTRING(PURP_OF_PAY FROM POSITION_FROM + 1 FOR POSITION_TO - POSITION_FROM - 1));
       if (BLOCK_NUMB = 2)  then  CASHIER_PHONE = trim(SUBSTRING(PURP_OF_PAY FROM POSITION_FROM + 1 FOR POSITION_TO - POSITION_FROM - 1));
       if (BLOCK_NUMB = 3)  then  INSURANCE_TYPE = trim(SUBSTRING(PURP_OF_PAY FROM POSITION_FROM + 1 FOR POSITION_TO - POSITION_FROM - 1));
       if (BLOCK_NUMB = 4)  then  CLIENT_FIO = trim(SUBSTRING(PURP_OF_PAY FROM POSITION_FROM + 1 FOR POSITION_TO - POSITION_FROM - 1));
       if (BLOCK_NUMB = 5)  then begin
           AUTO_VIN  = trim(SUBSTRING(PURP_OF_PAY FROM POSITION_FROM + 1 FOR POSITION_TO - POSITION_FROM - 1));
           if(char_length(AUTO_VIN) <> 17)then begin
                --ERRORS = ERRORS || ' /VIN!'; --Пока убрал...
           end
       end
       if (BLOCK_NUMB = 6)  then  CLIENT_PHONE         = trim(SUBSTRING(PURP_OF_PAY FROM POSITION_FROM + 1 FOR POSITION_TO - POSITION_FROM - 1));
       if (BLOCK_NUMB = 7)  then begin
           CLIENT_INN  = trim(SUBSTRING(PURP_OF_PAY FROM POSITION_FROM + 1 FOR POSITION_TO - POSITION_FROM - 1));
           if(char_length(CLIENT_INN) <> 10 and ID_CUSTOMER_TYPE = 1)then begin
                ERRORS = ERRORS || ' /ИНН не 10 знаков!';
           end
           if(char_length(CLIENT_INN) <> 8 and ID_CUSTOMER_TYPE = 2)then begin
                ERRORS = ERRORS || ' /ЕДРПО не 8 знаков!';
           end
       end                 
       if (BLOCK_NUMB = 8)  then begin
           CONTRACT_ENTRY_DATE  = trim(SUBSTRING(PURP_OF_PAY FROM POSITION_FROM + 1 FOR POSITION_TO - POSITION_FROM - 1));
           when any
              do begin
                CONTRACT_ENTRY_DATE = null;
                ERRORS = ERRORS || ' /Дата вступления!';
           end
       end
       if (BLOCK_NUMB = 9)  then  BANK_CODE = trim(SUBSTRING(PURP_OF_PAY FROM POSITION_FROM + 1 FOR POSITION_TO - POSITION_FROM - 1));
       if (BLOCK_NUMB = 10) then  AUTO_PLACE = trim(SUBSTRING(PURP_OF_PAY FROM POSITION_FROM + 1 FOR POSITION_TO - POSITION_FROM - 1));
       if (BLOCK_NUMB = 11) then  AUTO_NUMBER = trim(SUBSTRING(PURP_OF_PAY FROM POSITION_FROM + 1 FOR POSITION_TO - POSITION_FROM - 1));
       if (BLOCK_NUMB = 12) then  AUTO_MARK = trim(SUBSTRING(PURP_OF_PAY FROM POSITION_FROM + 1 FOR POSITION_TO - POSITION_FROM - 1));
       BLOCK_NUMB = BLOCK_NUMB + 1;
       POSITION_FROM = POSITION_TO;
      end
      POSITION_TO = POSITION_TO +1;
    END
	
	--Если ФИЗ-лицо - парсим ФИО
    if (ID_CUSTOMER_TYPE = 1) then begin
       last_name = trim(substring(trim(:CLIENT_FIO) from 1 for position(' ' in trim(:CLIENT_FIO))));
       first_name = trim(substring(substring(trim(:CLIENT_FIO) from position(' ' in trim(:CLIENT_FIO)) + 1) from 1 for position(' ' in substring(trim(:CLIENT_FIO) from position(' ' in trim(:CLIENT_FIO)) + 1))));
       patronimic_name = trim(substring(trim(:CLIENT_FIO) from position(' ' in trim(:CLIENT_FIO)) + 1 + position(' ' in substring(trim(:CLIENT_FIO) from position(' ' in trim(:CLIENT_FIO)) + 1))));
    end
	
	--Вставка
     insert into T_TEMP_TABLE (INT_FIELD1, INT_FIELD2, INT_FIELD3, INT_FIELD7, STR_FIELD1, STR_FIELD2, STR_FIELD3, STR_FIELD4, STR_FIELD5, STR_FIELD6, STR_FIELD7, DATE_FIELD2, STR_FIELD9, STR_FIELD10, STR_FIELD11, STR_FIELD12, STR_FIELD13, STR_FIELD14, STR_FIELD15, CURR_FIELD1, DATE_FIELD1, STR_FIELD20, STR_FIELD16)
     values (:TEMP_KEY, :ID_PAYMENT, :ID_CASH_FLOW, :ID_CUSTOMER_TYPE, :CASHIER_NUMBER, :CASHIER_PHONE, :INSURANCE_TYPE, :CLIENT_FIO, :AUTO_VIN, :CLIENT_PHONE, :CLIENT_INN, :CONTRACT_ENTRY_DATE, :BANK_CODE, :AUTO_PLACE, :AUTO_NUMBER, :AUTO_MARK, :LAST_NAME, :FIRST_NAME, :PATRONIMIC_NAME,
      :FACT_SUM, :cf_date, trim(:ERRORS),
	  :NOTE);
     ERRORS = '';
  end
end

/* --Проверка
select
--t.INT_FIELD1,
t.INT_FIELD2 as ID_PAYMENT,
t.STR_FIELD16 as NOTE,
--t.INT_FIELD3 as ID_CASH_FLOW,
--t.STR_FIELD3 as INSURANCE_TYPE,
t.INT_FIELD4 as ID_CUSTOMER, --ID контрагента
t.INT_FIELD7 as ID_CUSTOMER_TYPE, --Тип контрагента 
t.STR_FIELD4 as CLIENT_FIO,
t.STR_FIELD13 as LAST_NAME,
t.STR_FIELD14 as FIRST_NAME,
t.STR_FIELD15 as PATRONIMIC_NAME,
t.STR_FIELD6 as CLIENT_PHONE,
t.STR_FIELD7 as CLIENT_INN,
t.INT_FIELD6 as ID_DOC,      --ID договора
t.DATE_FIELD1 as DATE_DOC,
t.DATE_FIELD2 as INURE_DATE_DOC, --CONTRACT_ENTRY_DATE,
t.CURR_FIELD1 as FACT_SUM,
t.INT_FIELD5 as ID_AUTO,     --ID авто???
t.STR_FIELD5 as AUTO_VIN,
t.STR_FIELD10 as AUTO_PLACE,
t.STR_FIELD11 as AUTO_NUMBER,
t.STR_FIELD12 as AUTO_MARK,
t.STR_FIELD1 as CASHIER_NUMBER,
t.STR_FIELD2 as CASHIER_PHONE,
t.STR_FIELD9 as BANK_CODE,
t.STR_FIELD20 as ERRORS
from T_TEMP_TABLE T
where T.INT_FIELD1 = 4240
/**/