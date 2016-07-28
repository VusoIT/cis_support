/*
Генерация Ощадбанк
Генерация договоров 
Мельников Т.В. 27.07.2016
/**/

execute block as
declare variable TEMP_KEY integer; --Ключ временной таблицы
declare variable ID_NUMBER integer; --Виртуальный ID записей
declare variable ID_BLANK TINTEGER; --ID бланка
declare variable BLANK_NUMBER tvarchar7;--TINTEGER; --Номер бланка
declare variable id_customer TINTEGER; --ID Контрагента
declare variable ID_DOC tinteger; --ID Договора
declare variable DATE_DOC tdate; --Дата договора и дата вступления
declare variable id_contract_customer tinteger;
declare variable id_contract_customer_native tinteger;
declare variable ID_CONTRACT_BENEFICIARY tinteger;
declare variable ID_INSURANCE tinteger;
declare variable ID_OBJ tinteger;
declare variable INSURANCE_PAYMENT TMONEY;
declare variable closed_period tdate;
declare variable m_generation integer;  --месяц генерации
declare variable y_generation integer;  --год генерации
declare variable LOADING TNUMERIC5_2; --Нагрузка
declare variable BONUS TNUMERIC16_4; --Бонус малус
declare variable id_sale_channel tinteger; --Канал продаж
declare variable ID_OFFICER tinteger; --Отв. сотрудник
declare variable ID_TARIFF_MEMBER tinteger; --Тариф
declare variable FRANCHISE_CUR TMONEY;  --Франшиза в грн.
declare variable NOTE varchar(1000); --Примечание
declare variable REPORT_PERIOD tdate; --Отчетный период
--declare variable ID_AUTO tinteger,
declare variable AUTO_VIN varchar(1000);
declare variable AUTO_PLACE varchar(1000);
declare variable AUTO_NUMBER varchar(1000);
declare variable AUTO_MARK varchar(1000);

--Пременные, что учавствуют в логике по сумме
declare variable INTERNAL_REINSURANCE FLOAT; --Внутреннее перестрахование
declare variable RESERVE_PAYMENTS FLOAT; --Резерв выплат
declare variable K1 TNUMERIC18_15;
declare variable K2 TNUMERIC18_15;
declare variable K3 TNUMERIC18_15;
declare variable K4 TNUMERIC18_15;
declare variable K5 TNUMERIC18_15;
declare variable K6 TNUMERIC18_15;
declare variable K7 TNUMERIC18_15;
declare variable K8 TNUMERIC18_15;
declare variable ID_PLACE_ZONE tinteger; --ID Зоны (Населения городов B_ADDR_PLACES_ZONES)
declare variable ID_AUTO_CATEGORY tinteger;  --ID категории авто
declare variable ID_PRIVILEGE tinteger;
declare variable end_date_doc tdate; --Дата окончания договора
--declare variable contract_period  tinteger; --Период действия дней
--Пременные, что учавствуют в логике по сумме (конец)


begin
  --Настройки
  TEMP_KEY = 4240;
  
  --Константы
  ID_BLANK = -1;
  blank_number = null;
  LOADING = 35;
  BONUS = 0.8;
  id_sale_channel = 105;
  ID_OFFICER = 102448; --Теслюк М.В.
  ID_TARIFF_MEMBER = 20813;--20820;
  FRANCHISE_CUR = 0; --0 в интерфейсе КИС, выглядит, как NULL... Если поставить 1000 (например) - все отобразится нормально...

  --Получаем дату закрытого периода
  select closed_period from sys_options into :closed_period;

  --Генерация договоров
  for
    select
     --t.INT_FIELD1,
     t.INT_FIELD2 as ID_PAYMENT,
     t.CURR_FIELD1 as FACT_SUM,
     t.DATE_FIELD1 as DATE_DOC,
     t.INT_FIELD4 as ID_CUSTOMER,
     t.STR_FIELD16 as NOTE,

     --t.INT_FIELD5 as ID_AUTO,
     t.STR_FIELD5 as AUTO_VIN,
     t.STR_FIELD10 as AUTO_PLACE,
     t.STR_FIELD11 as AUTO_NUMBER,
     t.STR_FIELD12 as AUTO_MARK

    from T_TEMP_TABLE T
    where T.INT_FIELD1 = 4240
    and t.INT_FIELD7 <> 0 --ID_CUSTOMER_TYPE (только корректно обработанные суммы - определен тип контрагента)
    into :ID_NUMBER,  :INSURANCE_PAYMENT, :date_doc, :ID_CUSTOMER, :NOTE, :AUTO_VIN, :AUTO_PLACE, :AUTO_NUMBER, :AUTO_MARK

  do
  begin

end_date_doc = dateadd(1 year TO :DATE_DOC)-1;
  
K1=1; K2=4.8; K3=1; K4=1.5; K5=1; K6=1; K7=1;
ID_AUTO_CATEGORY = 3; --Удалить!
ID_PLACE_ZONE = 1;    --Удалить!
ID_PRIVILEGE = 0;

--Логика по суммам
--ФИЗ
--1
if (:INSURANCE_PAYMENT = 556.42) then
begin
  K1 = 1;
  K2 = 4.80;
  K3 = 1;
  K4 = 1.61;
  ID_AUTO_CATEGORY = 3;
  ID_PLACE_ZONE = 1;
  ID_PRIVILEGE = 4;
end
if (:INSURANCE_PAYMENT = 270.00) then
begin
  K1 = 1;
  K2 = 2.5;
  K3 = 1;
  K4 = 1.5;
  ID_AUTO_CATEGORY = 3;
  ID_PLACE_ZONE = 2;
  ID_PRIVILEGE = 4;
end
if (:INSURANCE_PAYMENT = 367.20) then
begin
  K1 = 1;
  K2 = 3.40;
  K3 = 1;
  K4 = 1.5;
  ID_AUTO_CATEGORY = 3;
  ID_PLACE_ZONE = 3;
  ID_PRIVILEGE = 4;
end
if (:INSURANCE_PAYMENT = 302.40) then
begin
  K1 = 1;
  K2 = 2.8;
  K3 = 1;
  K4 = 1.5;
  ID_AUTO_CATEGORY = 3;
  ID_PLACE_ZONE = 4;
  ID_PRIVILEGE = 4;
end
if (:INSURANCE_PAYMENT = 237.60) then
begin
  K1 = 1;
  K2 = 2.2;
  K3 = 1;
  K4 = 1.5;
  ID_AUTO_CATEGORY = 3;
  ID_PLACE_ZONE = 5;
  ID_PRIVILEGE = 4;
end
if (:INSURANCE_PAYMENT = 162.00) then
begin
  K1 = 1;
  K2 = 1.5;
  K3 = 1;
  K4 = 1.5;
  ID_AUTO_CATEGORY = 3;
  ID_PLACE_ZONE = 6;
  ID_PRIVILEGE = 4;
end
if (:INSURANCE_PAYMENT = 347.76) then
begin
  K1 = 1;
  K2 = 3;
  K3 = 1;
  K4 = 1.61;
  ID_AUTO_CATEGORY = 3;
  ID_PLACE_ZONE = 7;
  ID_PRIVILEGE = 4;
end
--1(конец)
/**/

--2
if (:INSURANCE_PAYMENT = 590.98) then
begin
  K1 = 1.14;
  K2 = 4.80;
  K3 = 1;
  K4 = 1.5;
  ID_AUTO_CATEGORY = 4;
  ID_PLACE_ZONE = 1;
  ID_PRIVILEGE = 4;
end
if (:INSURANCE_PAYMENT = 307.80) then
begin
  K1 = 1.14;
  K2 = 2.5;
  K3 = 1;
  K4 = 1.5;
  ID_AUTO_CATEGORY = 4;
  ID_PLACE_ZONE = 2;
  ID_PRIVILEGE = 4;
end
if (:INSURANCE_PAYMENT = 418.61) then
begin
  K1 = 1.14;
  K2 = 3.4;
  K3 = 1;
  K4 = 1.5;
  ID_AUTO_CATEGORY = 4;
  ID_PLACE_ZONE = 3;
  ID_PRIVILEGE = 4;
end
if (:INSURANCE_PAYMENT = 344.74) then
begin
  K1 = 1.14;
  K2 = 2.8;
  K3 = 1;
  K4 = 1.5;
  ID_AUTO_CATEGORY = 4;
  ID_PLACE_ZONE = 4;
  ID_PRIVILEGE = 4;
end
if (:INSURANCE_PAYMENT = 270.86) then
begin
  K1 = 1.14;
  K2 = 2.2;
  K3 = 1;
  K4 = 1.5;
  ID_AUTO_CATEGORY = 4;
  ID_PLACE_ZONE = 5;
  ID_PRIVILEGE = 4;
end
if (:INSURANCE_PAYMENT = 184.68) then
begin
  K1 = 1.14;
  K2 = 1.5;
  K3 = 1;
  K4 = 1.5;
  ID_AUTO_CATEGORY = 4;
  ID_PLACE_ZONE = 6;
  ID_PRIVILEGE = 4;
end
if (:INSURANCE_PAYMENT = 396.45) then
begin
  K1 = 1.14;
  K2 = 3;
  K3 = 1;
  K4 = 1.61;
  ID_AUTO_CATEGORY = 4;
  ID_PLACE_ZONE = 7;
  ID_PRIVILEGE = 4;
end
--2(конец)
/**/

--3
if (:INSURANCE_PAYMENT = 611.71) then
begin
  K1 = 1.18;
  K2 = 4.8;
  K3 = 1;
  K4 = 1.5;
  ID_AUTO_CATEGORY = 5;
  ID_PLACE_ZONE = 1;
  ID_PRIVILEGE = 4;
end
if (:INSURANCE_PAYMENT = 318.60) then
begin
  K1 = 1.18;
  K2 = 2.5;
  K3 = 1;
  K4 = 1.5;
  ID_AUTO_CATEGORY = 5;
  ID_PLACE_ZONE = 2;
  ID_PRIVILEGE = 4;
end
if (:INSURANCE_PAYMENT = 433.30) then
begin
  K1 = 1.18;
  K2 = 3.4;
  K3 = 1;
  K4 = 1.5;
  ID_AUTO_CATEGORY = 5;
  ID_PLACE_ZONE = 3;
  ID_PRIVILEGE = 4;
end
if (:INSURANCE_PAYMENT = 356.83) then
begin
  K1 = 1.18;
  K2 = 2.8;
  K3 = 1;
  K4 = 1.5;
  ID_AUTO_CATEGORY = 5;
  ID_PLACE_ZONE = 4;
  ID_PRIVILEGE = 4;
end
if (:INSURANCE_PAYMENT = 280.37) then
begin
  K1 = 1.18;
  K2 = 2.2;
  K3 = 1;
  K4 = 1.5;
  ID_AUTO_CATEGORY = 5;
  ID_PLACE_ZONE = 5;
  ID_PRIVILEGE = 4;
end
if (:INSURANCE_PAYMENT = 191.16) then
begin
  K1 = 1.18;
  K2 = 1.5;
  K3 = 1;
  K4 = 1.5;
  ID_AUTO_CATEGORY = 5;
  ID_PLACE_ZONE = 6;
  ID_PRIVILEGE = 4;
end
if (:INSURANCE_PAYMENT = 410.36) then
begin
  K1 = 1.18;
  K2 = 3;
  K3 = 1;
  K4 = 1.61;
  ID_AUTO_CATEGORY = 5;
  ID_PLACE_ZONE = 7;
  ID_PRIVILEGE = 4;
end
--3(конец)
/**/

--4
if (:INSURANCE_PAYMENT = 1036.80) then
begin
  K1 = 1;
  K2 = 4.8;
  K3 = 1;
  K4 = 1.5;
  ID_AUTO_CATEGORY = 3;
  ID_PLACE_ZONE = 1;
  ID_PRIVILEGE = 0;
end
if (:INSURANCE_PAYMENT = 540.00) then
begin
  K1 = 1;
  K2 = 2.5;
  K3 = 1;
  K4 = 1.5;
  ID_AUTO_CATEGORY = 3;
  ID_PLACE_ZONE = 2;
  ID_PRIVILEGE = 0;
end
if (:INSURANCE_PAYMENT = 734.40) then
begin
  K1 = 1;
  K2 = 3.4;
  K3 = 1;
  K4 = 1.5;
  ID_AUTO_CATEGORY = 3;
  ID_PLACE_ZONE = 3;
  ID_PRIVILEGE = 0;
end
if (:INSURANCE_PAYMENT = 604.80) then
begin
  K1 = 1;
  K2 = 2.8;
  K3 = 1;
  K4 = 1.5;
  ID_AUTO_CATEGORY = 3;
  ID_PLACE_ZONE = 4;
  ID_PRIVILEGE = 0;
end
if (:INSURANCE_PAYMENT = 475.20) then
begin
  K1 = 1;
  K2 = 2.2;
  K3 = 1;
  K4 = 1.5;
  ID_AUTO_CATEGORY = 3;
  ID_PLACE_ZONE = 5;
  ID_PRIVILEGE = 0;
end
if (:INSURANCE_PAYMENT = 324.00) then
begin
  K1 = 1;
  K2 = 1.5;
  K3 = 1;
  K4 = 1.5;
  ID_AUTO_CATEGORY = 3;
  ID_PLACE_ZONE = 6;
  ID_PRIVILEGE = 0;
end
if (:INSURANCE_PAYMENT = 691.20) then
begin
  K1 = 1;
  K2 = 3;
  K3 = 1;
  K4 = 1.60;
  ID_AUTO_CATEGORY = 3;
  ID_PLACE_ZONE = 7;
  ID_PRIVILEGE = 0;
end
--4(конец)
/**/

--5
if (:INSURANCE_PAYMENT = 1181.95) then
begin
  K1 = 1.4;
  K2 = 4.8;
  K3 = 1;
  K4 = 1.5;
  ID_AUTO_CATEGORY = 4;
  ID_PLACE_ZONE = 1;
  ID_PRIVILEGE = 0;
end
if (:INSURANCE_PAYMENT = 615.60) then
begin
  K1 = 1.4;
  K2 = 2.5;
  K3 = 1;
  K4 = 1.5;
  ID_AUTO_CATEGORY = 4;
  ID_PLACE_ZONE = 2;
  ID_PRIVILEGE = 0;
end
if (:INSURANCE_PAYMENT = 837.22) then
begin
  K1 = 1.4;
  K2 = 3.4;
  K3 = 1;
  K4 = 1.5;
  ID_AUTO_CATEGORY = 4;
  ID_PLACE_ZONE = 3;
  ID_PRIVILEGE = 0;
end
if (:INSURANCE_PAYMENT = 689.47) then
begin
  K1 = 1.4;
  K2 = 2.8;
  K3 = 1;
  K4 = 1.5;
  ID_AUTO_CATEGORY = 4;
  ID_PLACE_ZONE = 4;
  ID_PRIVILEGE = 0;
end
if (:INSURANCE_PAYMENT = 541.73) then
begin
  K1 = 1.4;
  K2 = 2.2;
  K3 = 1;
  K4 = 1.5;
  ID_AUTO_CATEGORY = 4;
  ID_PLACE_ZONE = 5;
  ID_PRIVILEGE = 0;
end
if (:INSURANCE_PAYMENT = 369.36) then
begin
  K1 = 1.4;
  K2 = 1.5;
  K3 = 1;
  K4 = 1.5;
  ID_AUTO_CATEGORY = 4;
  ID_PLACE_ZONE = 6;
  ID_PRIVILEGE = 0;
end
if (:INSURANCE_PAYMENT = 738.72) then
begin
  K1 = 1.4;
  K2 = 3;
  K3 = 1;
  K4 = 1.5;
  ID_AUTO_CATEGORY = 4;
  ID_PLACE_ZONE = 7;
  ID_PRIVILEGE = 0;
end
--5(конец)
/**/

--6
if (:INSURANCE_PAYMENT = 1223.42) then
begin
  K1 = 1.18;
  K2 = 4.8;
  K3 = 1;
  K4 = 1.5;
  ID_AUTO_CATEGORY = 5;
  ID_PLACE_ZONE = 1;
  ID_PRIVILEGE = 0;
end
if (:INSURANCE_PAYMENT = 637.20) then
begin
  K1 = 1.18;
  K2 = 2.5;
  K3 = 1;
  K4 = 1.5;
  ID_AUTO_CATEGORY = 5;
  ID_PLACE_ZONE = 2;
  ID_PRIVILEGE = 0;
end
if (:INSURANCE_PAYMENT = 866.59) then
begin
  K1 = 1.18;
  K2 = 3.4;
  K3 = 1;
  K4 = 1.5;
  ID_AUTO_CATEGORY = 5;
  ID_PLACE_ZONE = 3;
  ID_PRIVILEGE = 0;
end
if (:INSURANCE_PAYMENT = 713.66) then
begin
  K1 = 1.18;
  K2 = 2.8;
  K3 = 1;
  K4 = 1.5;
  ID_AUTO_CATEGORY = 5;
  ID_PLACE_ZONE = 4;
  ID_PRIVILEGE = 0;
end
if (:INSURANCE_PAYMENT = 560.74) then
begin
  K1 = 1.18;
  K2 = 2.2;
  K3 = 1;
  K4 = 1.5;
  ID_AUTO_CATEGORY = 5;
  ID_PLACE_ZONE = 5;
  ID_PRIVILEGE = 0;
end
if (:INSURANCE_PAYMENT = 382.32) then
begin
  K1 = 1.18;
  K2 = 1.5;
  K3 = 1;
  K4 = 1.5;
  ID_AUTO_CATEGORY = 5;
  ID_PLACE_ZONE = 6;
  ID_PRIVILEGE = 0;
end
if (:INSURANCE_PAYMENT = 764.64) then
begin
  K1 = 1.18;
  K2 = 3;
  K3 = 1;
  K4 = 1.5;
  ID_AUTO_CATEGORY = 5;
  ID_PLACE_ZONE = 7;
  ID_PRIVILEGE = 0;
end
--6(конец)
/**/

--7
if (:INSURANCE_PAYMENT = 1886.98) then
begin
  K1 = 1.82;
  K2 = 4.8;
  K3 = 1;
  K4 = 1.5;
  ID_AUTO_CATEGORY = 6;
  ID_PLACE_ZONE = 1;
  ID_PRIVILEGE = 0;
end
if (:INSURANCE_PAYMENT = 982.80) then
begin
  K1 = 1.82;
  K2 = 2.5;
  K3 = 1;
  K4 = 1.5;
  ID_AUTO_CATEGORY = 6;
  ID_PLACE_ZONE = 2;
  ID_PRIVILEGE = 0;
end
if (:INSURANCE_PAYMENT = 1336.61) then
begin
  K1 = 1.82;
  K2 = 3.4;
  K3 = 1;
  K4 = 1.5;
  ID_AUTO_CATEGORY = 6;
  ID_PLACE_ZONE = 3;
  ID_PRIVILEGE = 0;
end
if (:INSURANCE_PAYMENT = 1100.74) then
begin
  K1 = 1.82;
  K2 = 2.8;
  K3 = 1;
  K4 = 1.5;
  ID_AUTO_CATEGORY = 6;
  ID_PLACE_ZONE = 4;
  ID_PRIVILEGE = 0;
end
if (:INSURANCE_PAYMENT = 864.86) then
begin
  K1 = 1.82;
  K2 = 2.2;
  K3 = 1;
  K4 = 1.5;
  ID_AUTO_CATEGORY = 6;
  ID_PLACE_ZONE = 5;
  ID_PRIVILEGE = 0;
end
if (:INSURANCE_PAYMENT = 589.68) then
begin
  K1 = 1.82;
  K2 = 1.5;
  K3 = 1;
  K4 = 1.5;
  ID_AUTO_CATEGORY = 6;
  ID_PLACE_ZONE = 6;
  ID_PRIVILEGE = 0;
end
if (:INSURANCE_PAYMENT = 1179.36) then
begin
  K1 = 1.82;
  K2 = 3;
  K3 = 1;
  K4 = 1.5;
  ID_AUTO_CATEGORY = 6;
  ID_PLACE_ZONE = 7;
  ID_PRIVILEGE = 0;
end
--7(конец)
/**/

--8
if (:INSURANCE_PAYMENT = 352.51) then
begin
  K1 = 0.34;
  K2 = 4.8;
  K3 = 1;
  K4 = 1.5;
  ID_AUTO_CATEGORY = 12;
  ID_PLACE_ZONE = 1;
  ID_PRIVILEGE = 0;
end
if (:INSURANCE_PAYMENT = 183.60) then
begin
  K1 = 0.34;
  K2 = 2.5;
  K3 = 1;
  K4 = 1.5;
  ID_AUTO_CATEGORY = 12;
  ID_PLACE_ZONE = 2;
  ID_PRIVILEGE = 0;
end
if (:INSURANCE_PAYMENT = 249.70) then
begin
  K1 = 0.34;
  K2 = 3.4;
  K3 = 1;
  K4 = 1.5;
  ID_AUTO_CATEGORY = 12;
  ID_PLACE_ZONE = 3;
  ID_PRIVILEGE = 0;
end
if (:INSURANCE_PAYMENT = 205.63) then
begin
  K1 = 0.34;
  K2 = 2.8;
  K3 = 1;
  K4 = 1.5;
  ID_AUTO_CATEGORY = 12;
  ID_PLACE_ZONE = 4;
  ID_PRIVILEGE = 0;
end
if (:INSURANCE_PAYMENT = 161.57) then
begin
  K1 = 0.34;
  K2 = 2.2;
  K3 = 1;
  K4 = 1.5;
  ID_AUTO_CATEGORY = 12;
  ID_PLACE_ZONE = 5;
  ID_PRIVILEGE = 0;
end
if (:INSURANCE_PAYMENT = 110.16) then
begin
  K1 = 0.34;
  K2 = 1.5;
  K3 = 1;
  K4 = 1.5;
  ID_AUTO_CATEGORY = 12;
  ID_PLACE_ZONE = 6;
  ID_PRIVILEGE = 0;
end
if (:INSURANCE_PAYMENT = 220.32) then
begin
  K1 = 0.34;
  K2 = 3;
  K3 = 1;
  K4 = 1.5;
  ID_AUTO_CATEGORY = 12;
  ID_PLACE_ZONE = 7;
  ID_PRIVILEGE = 0;
end
--8(конец)
/**/

--9
if (:INSURANCE_PAYMENT = 1850.69) then
begin
  K1 = 2.55;
  K2 = 4.8;
  K3 = 1;
  K4 = 1.5;
  ID_AUTO_CATEGORY = 9;
  ID_PLACE_ZONE = 1;
  ID_PRIVILEGE = 0;
  end_date_doc = dateadd(6 month TO :DATE_DOC) - 1;
end
if (:INSURANCE_PAYMENT = 963.90) then
begin
  K1 = 2.55;
  K2 = 2.5;
  K3 = 1;
  K4 = 1.5;
  ID_AUTO_CATEGORY = 9;
  ID_PLACE_ZONE = 2;
  ID_PRIVILEGE = 0;
  end_date_doc = dateadd(6 month TO :DATE_DOC) - 1;
end
if (:INSURANCE_PAYMENT = 1310.90) then
begin
  K1 = 2.55;
  K2 = 3.4;
  K3 = 1;
  K4 = 1.5;
  ID_AUTO_CATEGORY = 9;
  ID_PLACE_ZONE = 3;
  ID_PRIVILEGE = 0;
  end_date_doc = dateadd(6 month TO :DATE_DOC) - 1;
end
if (:INSURANCE_PAYMENT = 1079.57) then
begin
  K1 = 2.55;
  K2 = 2.8;
  K3 = 1;
  K4 = 1.5;
  ID_AUTO_CATEGORY = 9;
  ID_PLACE_ZONE = 4;
  ID_PRIVILEGE = 0;
  end_date_doc = dateadd(6 month TO :DATE_DOC) - 1;
end
if (:INSURANCE_PAYMENT = 848.23) then
begin
  K1 = 2.55;
  K2 = 2.2;
  K3 = 1;
  K4 = 1.5;
  ID_AUTO_CATEGORY = 9;
  ID_PLACE_ZONE = 5;
  ID_PRIVILEGE = 0;
  end_date_doc = dateadd(6 month TO :DATE_DOC) - 1;
end
if (:INSURANCE_PAYMENT = 578.34) then
begin
  K1 = 2.55;
  K2 = 1.5;
  K3 = 1;
  K4 = 1.5;
  ID_AUTO_CATEGORY = 9;
  ID_PLACE_ZONE = 6;
  ID_PRIVILEGE = 0;
  end_date_doc = dateadd(6 month TO :DATE_DOC) - 1;
end
if (:INSURANCE_PAYMENT = 1156.68) then
begin
  K1 = 2.55;
  K2 = 3;
  K3 = 1;
  K4 = 1.5;
  ID_AUTO_CATEGORY = 9;
  ID_PLACE_ZONE = 7;
  ID_PRIVILEGE = 0;
  end_date_doc = dateadd(6 month TO :DATE_DOC) - 1;
end
--9(конец)
/**/

--10
if (:INSURANCE_PAYMENT = 2177.28) then
begin
  K1 = 3;
  K2 = 4.8;
  K3 = 1;
  K4 = 1.5;
  ID_AUTO_CATEGORY = 10;
  ID_PLACE_ZONE = 1;
  ID_PRIVILEGE = 0;
  end_date_doc = dateadd(6 month TO :DATE_DOC) - 1;
end
if (:INSURANCE_PAYMENT = 1134.00) then
begin
  K1 = 3;
  K2 = 2.5;
  K3 = 1;
  K4 = 1.5;
  ID_AUTO_CATEGORY = 10;
  ID_PLACE_ZONE = 2;
  ID_PRIVILEGE = 0;
  end_date_doc = dateadd(6 month TO :DATE_DOC) - 1;
end
if (:INSURANCE_PAYMENT = 1542.24) then
begin
  K1 = 3;
  K2 = 3.4;
  K3 = 1;
  K4 = 1.5;
  ID_AUTO_CATEGORY = 10;
  ID_PLACE_ZONE = 3;
  ID_PRIVILEGE = 0;
  end_date_doc = dateadd(6 month TO :DATE_DOC) - 1;
end
if (:INSURANCE_PAYMENT = 1270.08) then
begin
  K1 = 3;
  K2 = 2.8;
  K3 = 1;
  K4 = 1.5;
  ID_AUTO_CATEGORY = 10;
  ID_PLACE_ZONE = 4;
  ID_PRIVILEGE = 0;
  end_date_doc = dateadd(6 month TO :DATE_DOC) - 1;
end
if (:INSURANCE_PAYMENT = 997.92) then
begin
  K1 = 3;
  K2 = 2.2;
  K3 = 1;
  K4 = 1.5;
  ID_AUTO_CATEGORY = 10;
  ID_PLACE_ZONE = 5;
  ID_PRIVILEGE = 0;
  end_date_doc = dateadd(6 month TO :DATE_DOC) - 1;
end
if (:INSURANCE_PAYMENT = 680.40) then
begin
  K1 = 3;
  K2 = 1.5;
  K3 = 1;
  K4 = 1.5;
  ID_AUTO_CATEGORY = 10;
  ID_PLACE_ZONE = 6;
  ID_PRIVILEGE = 0;
  end_date_doc = dateadd(6 month TO :DATE_DOC) - 1;
end
if (:INSURANCE_PAYMENT = 1360.80) then
begin
  K1 = 3;
  K2 = 3;
  K3 = 1;
  K4 = 1.5;
  ID_AUTO_CATEGORY = 10;
  ID_PLACE_ZONE = 7;
  ID_PRIVILEGE = 0;
  end_date_doc = dateadd(6 month TO :DATE_DOC) - 1;
end
--10(конец)
/**/

--11
if (:INSURANCE_PAYMENT = 2073.60) then
begin
  K1 = 2;
  K2 = 4.8;
  K3 = 1;
  K4 = 1.5;
  ID_AUTO_CATEGORY = 7;
  ID_PLACE_ZONE = 1;
  ID_PRIVILEGE = 0;
end
if (:INSURANCE_PAYMENT = 1080.00) then
begin
  K1 = 2;
  K2 = 2.5;
  K3 = 1;
  K4 = 1.5;
  ID_AUTO_CATEGORY = 7;
  ID_PLACE_ZONE = 2;
  ID_PRIVILEGE = 0;
end
if (:INSURANCE_PAYMENT = 1468.80) then
begin
  K1 = 2;
  K2 = 3.4;
  K3 = 1;
  K4 = 1.5;
  ID_AUTO_CATEGORY = 7;
  ID_PLACE_ZONE = 3;
  ID_PRIVILEGE = 0;
end
if (:INSURANCE_PAYMENT = 1209.60) then
begin
  K1 = 2;
  K2 = 2.8;
  K3 = 1;
  K4 = 1.5;
  ID_AUTO_CATEGORY = 7;
  ID_PLACE_ZONE = 4;
  ID_PRIVILEGE = 0;
end
if (:INSURANCE_PAYMENT = 950.40) then
begin
  K1 = 2;
  K2 = 2.2;
  K3 = 1;
  K4 = 1.5;
  ID_AUTO_CATEGORY = 7;
  ID_PLACE_ZONE = 5;
  ID_PRIVILEGE = 0;
end
if (:INSURANCE_PAYMENT = 648.00) then
begin
  K1 = 2;
  K2 = 1.5;
  K3 = 1;
  K4 = 1.5;
  ID_AUTO_CATEGORY = 7;
  ID_PLACE_ZONE = 6;
  ID_PRIVILEGE = 0;
end
if (:INSURANCE_PAYMENT = 1382.40) then
begin
  K1 = 2;
  K2 = 3;
  K3 = 1;
  K4 = 1.60;
  ID_AUTO_CATEGORY = 7;
  ID_PLACE_ZONE = 7;
  ID_PRIVILEGE = 0;
end
--11(конец)
/**/

--12
if (:INSURANCE_PAYMENT = 2260.22) then
begin
  K1 = 2.18;
  K2 = 4.8;
  K3 = 1;
  K4 = 1.5;
  ID_AUTO_CATEGORY = 8;
  ID_PLACE_ZONE = 1;
  ID_PRIVILEGE = 0;
end
if (:INSURANCE_PAYMENT = 1177.20) then
begin
  K1 = 2.18;
  K2 = 2.5;
  K3 = 1;
  K4 = 1.5;
  ID_AUTO_CATEGORY = 8;
  ID_PLACE_ZONE = 2;
  ID_PRIVILEGE = 0;
end
if (:INSURANCE_PAYMENT = 1600.99) then
begin
  K1 = 2.18;
  K2 = 3.4;
  K3 = 1;
  K4 = 1.5;
  ID_AUTO_CATEGORY = 8;
  ID_PLACE_ZONE = 3;
  ID_PRIVILEGE = 0;
end
if (:INSURANCE_PAYMENT = 1318.46) then
begin
  K1 = 2.18;
  K2 = 2.8;
  K3 = 1;
  K4 = 1.5;
  ID_AUTO_CATEGORY = 8;
  ID_PLACE_ZONE = 4;
  ID_PRIVILEGE = 0;
end
if (:INSURANCE_PAYMENT = 1035.94) then
begin
  K1 = 2.18;
  K2 = 2.2;
  K3 = 1;
  K4 = 1.5;
  ID_AUTO_CATEGORY = 8;
  ID_PLACE_ZONE = 5;
  ID_PRIVILEGE = 0;
end
if (:INSURANCE_PAYMENT = 706.32) then
begin
  K1 = 2.18;
  K2 = 1.5;
  K3 = 1;
  K4 = 1.5;
  ID_AUTO_CATEGORY = 8;
  ID_PLACE_ZONE = 6;
  ID_PRIVILEGE = 0;
end
if (:INSURANCE_PAYMENT = 1412.64) then
begin
  K1 = 2.18;
  K2 = 3;
  K3 = 1;
  K4 = 1.5;
  ID_AUTO_CATEGORY = 8;
  ID_PLACE_ZONE = 7;
  ID_PRIVILEGE = 0;
end
--12(конец)
/**/

--13
if (:INSURANCE_PAYMENT = 552.96) then
begin
  K1 = 0.5;
  K2 = 4.8;
  K3 = 1;
  K4 = 1.6;
  ID_AUTO_CATEGORY = 11;
  ID_PLACE_ZONE = 1;
  ID_PRIVILEGE = 0;
end
if (:INSURANCE_PAYMENT = 288.00) then
begin
  K1 = 0.5;
  K2 = 2.5;
  K3 = 1;
  K4 = 1.6;
  ID_AUTO_CATEGORY = 11;
  ID_PLACE_ZONE = 2;
  ID_PRIVILEGE = 0;
end
if (:INSURANCE_PAYMENT = 391.68) then
begin
  K1 = 0.5;
  K2 = 3.4;
  K3 = 1;
  K4 = 1.6;
  ID_AUTO_CATEGORY = 11;
  ID_PLACE_ZONE = 3;
  ID_PRIVILEGE = 0;
end
if (:INSURANCE_PAYMENT = 322.56) then
begin
  K1 = 0.5;
  K2 = 2.8;
  K3 = 1;
  K4 = 1.6;
  ID_AUTO_CATEGORY = 11;
  ID_PLACE_ZONE = 4;
  ID_PRIVILEGE = 0;
end
if (:INSURANCE_PAYMENT = 253.44) then
begin
  K1 = 0.5;
  K2 = 2.2;
  K3 = 1;
  K4 = 1.6;
  ID_AUTO_CATEGORY = 11;
  ID_PLACE_ZONE = 5;
  ID_PRIVILEGE = 0;
end
if (:INSURANCE_PAYMENT = 172.80) then
begin
  K1 = 0.5;
  K2 = 1.5;
  K3 = 1;
  K4 = 1.6;
  ID_AUTO_CATEGORY = 11;
  ID_PLACE_ZONE = 6;
  ID_PRIVILEGE = 0;
end
if (:INSURANCE_PAYMENT = 345.60) then
begin
  K1 = 0.5;
  K2 = 3;
  K3 = 1;
  K4 = 1.6;
  ID_AUTO_CATEGORY = 11;
  ID_PLACE_ZONE = 7;
  ID_PRIVILEGE = 0;
end
--13(конец)
/**/

--14
if (:INSURANCE_PAYMENT = 376.01) then
begin
  K1 = 0.34;
  K2 = 4.8;
  K3 = 1;
  K4 = 1.6;
  ID_AUTO_CATEGORY = 1;
  ID_PLACE_ZONE = 1;
  ID_PRIVILEGE = 0;
end
if (:INSURANCE_PAYMENT = 195.84) then
begin
  K1 = 0.34;
  K2 = 2.5;
  K3 = 1;
  K4 = 1.6;
  ID_AUTO_CATEGORY = 1;
  ID_PLACE_ZONE = 2;
  ID_PRIVILEGE = 0;
end
if (:INSURANCE_PAYMENT = 266.34) then
begin
  K1 = 0.34;
  K2 = 3.4;
  K3 = 1;
  K4 = 1.6;
  ID_AUTO_CATEGORY = 1;
  ID_PLACE_ZONE = 3;
  ID_PRIVILEGE = 0;
end
if (:INSURANCE_PAYMENT = 219.34) then
begin
  K1 = 0.34;
  K2 = 2.8;
  K3 = 1;
  K4 = 1.5;
  ID_AUTO_CATEGORY = 1;
  ID_PLACE_ZONE = 4;
  ID_PRIVILEGE = 0;
end
if (:INSURANCE_PAYMENT = 172.34) then
begin
  K1 = 0.34;
  K2 = 2.2;
  K3 = 1;
  K4 = 1.6;
  ID_AUTO_CATEGORY = 1;
  ID_PLACE_ZONE = 5;
  ID_PRIVILEGE = 0;
end
if (:INSURANCE_PAYMENT = 117.50) then
begin
  K1 = 0.34;
  K2 = 1.5;
  K3 = 1;
  K4 = 1.6;
  ID_AUTO_CATEGORY = 1;
  ID_PLACE_ZONE = 6;
  ID_PRIVILEGE = 0;
end
if (:INSURANCE_PAYMENT = 235.01) then
begin
  K1 = 0.34;
  K2 = 3;
  K3 = 1;
  K4 = 1.6;
  ID_AUTO_CATEGORY = 1;
  ID_PLACE_ZONE = 7;
  ID_PRIVILEGE = 0;
end
--14(конец)
/**/

--15
if (:INSURANCE_PAYMENT = 705.02) then
begin
  K1 = 0.68;
  K2 = 4.8;
  K3 = 1;
  K4 = 1.5;
  ID_AUTO_CATEGORY = 2;
  ID_PLACE_ZONE = 1;
  ID_PRIVILEGE = 0;
end
if (:INSURANCE_PAYMENT = 403.92) then
begin
  K1 = 0.68;
  K2 = 2.5;
  K3 = 1;
  K4 = 1.65;
  ID_AUTO_CATEGORY = 2;
  ID_PLACE_ZONE = 2;
  ID_PRIVILEGE = 0;
end
if (:INSURANCE_PAYMENT = 499.39) then
begin
  K1 = 0.68;
  K2 = 3.4;
  K3 = 1;
  K4 = 1.5;
  ID_AUTO_CATEGORY = 2;
  ID_PLACE_ZONE = 3;
  ID_PRIVILEGE = 0;
end
if (:INSURANCE_PAYMENT = 411.26) then
begin
  K1 = 0.68;
  K2 = 2.8;
  K3 = 1;
  K4 = 1.5;
  ID_AUTO_CATEGORY = 2;
  ID_PLACE_ZONE = 4;
  ID_PRIVILEGE = 0;
end
if (:INSURANCE_PAYMENT = 323.14) then
begin
  K1 = 0.68;
  K2 = 2.2;
  K3 = 1;
  K4 = 1.5;
  ID_AUTO_CATEGORY = 2;
  ID_PLACE_ZONE = 5;
  ID_PRIVILEGE = 0;
end
if (:INSURANCE_PAYMENT = 242.35) then
begin
  K1 = 0.68;
  K2 = 1.5;
  K3 = 1;
  K4 = 1.65;
  ID_AUTO_CATEGORY = 2;
  ID_PLACE_ZONE = 6;
  ID_PRIVILEGE = 0;
end
if (:INSURANCE_PAYMENT = 440.64) then
begin
  K1 = 0.68;
  K2 = 3;
  K3 = 1;
  K4 = 1.5;
  ID_AUTO_CATEGORY = 2;
  ID_PLACE_ZONE = 7;
  ID_PRIVILEGE = 0;
end
--15(конец)   
/**/

--------------------------------------------------------

--ЮР
--1ю
if (:INSURANCE_PAYMENT = 1078.27) then
begin
  K1 = 1;
  K2 = 4.8;
  K3 = 1.3;
  K4 = 1.2;
  ID_AUTO_CATEGORY = 3;
  ID_PLACE_ZONE = 1;
  ID_PRIVILEGE = 0;
end
if (:INSURANCE_PAYMENT = 561.60) then
begin
  K1 = 1;
  K2 = 2.5;
  K3 = 1.3;
  K4 = 1.2;
  ID_AUTO_CATEGORY = 3;
  ID_PLACE_ZONE = 2;
  ID_PRIVILEGE = 0;
end
if (:INSURANCE_PAYMENT = 763.78) then
begin
  K1 = 1;
  K2 = 3.4;
  K3 = 1.3;
  K4 = 1.2;
  ID_AUTO_CATEGORY = 3;
  ID_PLACE_ZONE = 3;
  ID_PRIVILEGE = 0;
end
if (:INSURANCE_PAYMENT = 628.99) then
begin
  K1 = 1;
  K2 = 2.8;
  K3 = 1.3;
  K4 = 1.2;
  ID_AUTO_CATEGORY = 3;
  ID_PLACE_ZONE = 4;
  ID_PRIVILEGE = 0;
end
if (:INSURANCE_PAYMENT = 494.21) then
begin
  K1 = 1;
  K2 = 2.2;
  K3 = 1.3;
  K4 = 1.2;
  ID_AUTO_CATEGORY = 3;
  ID_PLACE_ZONE = 5;
  ID_PRIVILEGE = 0;
end
if (:INSURANCE_PAYMENT = 336.96) then
begin
  K1 = 1;
  K2 = 1.5;
  K3 = 1.3;
  K4 = 1.2;
  ID_AUTO_CATEGORY = 3;
  ID_PLACE_ZONE = 6;
  ID_PRIVILEGE = 0;
end
if (:INSURANCE_PAYMENT = 673.92) then
begin
  K1 = 1;
  K2 = 3;
  K3 = 1.3;
  K4 = 1.2;
  ID_AUTO_CATEGORY = 3;
  ID_PLACE_ZONE = 7;
  ID_PRIVILEGE = 0;
end
--1ю(конец)
/**/

--2ю
if (:INSURANCE_PAYMENT = 1229.23) then
begin
  K1 = 1.4;
  K2 = 4.8;
  K3 = 1.3;
  K4 = 1.2;
  ID_AUTO_CATEGORY = 4;
  ID_PLACE_ZONE = 1;
  ID_PRIVILEGE = 0;
end
if (:INSURANCE_PAYMENT = 640.22) then
begin
  K1 = 1.4;
  K2 = 2.5;
  K3 = 1.3;
  K4 = 1.2;
  ID_AUTO_CATEGORY = 4;
  ID_PLACE_ZONE = 2;
  ID_PRIVILEGE = 0;
end
if (:INSURANCE_PAYMENT = 870.70) then
begin
  K1 = 1.4;
  K2 = 3.4;
  K3 = 1.3;
  K4 = 1.2;
  ID_AUTO_CATEGORY = 4;
  ID_PLACE_ZONE = 3;
  ID_PRIVILEGE = 0;
end
if (:INSURANCE_PAYMENT = 717.05) then
begin
  K1 = 1.4;
  K2 = 2.8;
  K3 = 1.3;
  K4 = 1.2;
  ID_AUTO_CATEGORY = 4;
  ID_PLACE_ZONE = 4;
  ID_PRIVILEGE = 0;
end
if (:INSURANCE_PAYMENT = 563.40) then
begin
  K1 = 1.4;
  K2 = 2.2;
  K3 = 1.3;
  K4 = 1.2;
  ID_AUTO_CATEGORY = 4;
  ID_PLACE_ZONE = 5;
  ID_PRIVILEGE = 0;
end
if (:INSURANCE_PAYMENT = 384.13) then
begin
  K1 = 1.4;
  K2 = 1.5;
  K3 = 1.3;
  K4 = 1.2;
  ID_AUTO_CATEGORY = 4;
  ID_PLACE_ZONE = 6;
  ID_PRIVILEGE = 0;
end
if (:INSURANCE_PAYMENT = 768.27) then
begin
  K1 = 1.4;
  K2 = 3;
  K3 = 1.3;
  K4 = 1.2;
  ID_AUTO_CATEGORY = 4;
  ID_PLACE_ZONE = 7;
  ID_PRIVILEGE = 0;
end
--2ю(конец)
/**/

--3ю
if (:INSURANCE_PAYMENT = 1272.36) then
begin
  K1 = 1.18;
  K2 = 4.8;
  K3 = 1.3;
  K4 = 1.2;
  ID_AUTO_CATEGORY = 5;
  ID_PLACE_ZONE = 1;
  ID_PRIVILEGE = 0;
end
if (:INSURANCE_PAYMENT = 662.69) then
begin
  K1 = 1.18;
  K2 = 2.5;
  K3 = 1.3;
  K4 = 1.2;
  ID_AUTO_CATEGORY = 5;
  ID_PLACE_ZONE = 2;
  ID_PRIVILEGE = 0;
end
if (:INSURANCE_PAYMENT = 901.26) then
begin
  K1 = 1.18;
  K2 = 3.4;
  K3 = 1.3;
  K4 = 1.2;
  ID_AUTO_CATEGORY = 5;
  ID_PLACE_ZONE = 3;
  ID_PRIVILEGE = 0;
end
if (:INSURANCE_PAYMENT = 742.21) then
begin
  K1 = 1.18;
  K2 = 2.8;
  K3 = 1.3;
  K4 = 1.2;
  ID_AUTO_CATEGORY = 5;
  ID_PLACE_ZONE = 4;
  ID_PRIVILEGE = 0;
end
if (:INSURANCE_PAYMENT = 583.17) then
begin
  K1 = 1.18;
  K2 = 2.2;
  K3 = 1.3;
  K4 = 1.2;
  ID_AUTO_CATEGORY = 5;
  ID_PLACE_ZONE = 5;
  ID_PRIVILEGE = 0;
end
if (:INSURANCE_PAYMENT = 397.61) then
begin
  K1 = 1.18;
  K2 = 1.5;
  K3 = 1.3;
  K4 = 1.2;
  ID_AUTO_CATEGORY = 5;
  ID_PLACE_ZONE = 6;
  ID_PRIVILEGE = 0;
end
if (:INSURANCE_PAYMENT = 795.23) then
begin
  K1 = 1.18;
  K2 = 3;
  K3 = 1.3;
  K4 = 1.2;
  ID_AUTO_CATEGORY = 5;
  ID_PLACE_ZONE = 7;
  ID_PRIVILEGE = 0;
end
--3ю(конец)
/**/

--4ю
if (:INSURANCE_PAYMENT = 1962.46) then
begin
  K1 = 1.82;
  K2 = 4.8;
  K3 = 1.3;
  K4 = 1.2;
  ID_AUTO_CATEGORY = 6;
  ID_PLACE_ZONE = 1;
  ID_PRIVILEGE = 0;
end
if (:INSURANCE_PAYMENT = 1022.11) then
begin
  K1 = 1.82;
  K2 = 2.5;
  K3 = 1.3;
  K4 = 1.2;
  ID_AUTO_CATEGORY = 6;
  ID_PLACE_ZONE = 2;
  ID_PRIVILEGE = 0;
end
if (:INSURANCE_PAYMENT = 1390.07) then
begin
  K1 = 1.82;
  K2 = 3.4;
  K3 = 1.3;
  K4 = 1.2;
  ID_AUTO_CATEGORY = 6;
  ID_PLACE_ZONE = 3;
  ID_PRIVILEGE = 0;
end
if (:INSURANCE_PAYMENT = 1144.77) then
begin
  K1 = 1.82;
  K2 = 2.8;
  K3 = 1.3;
  K4 = 1.2;
  ID_AUTO_CATEGORY = 6;
  ID_PLACE_ZONE = 4;
  ID_PRIVILEGE = 0;
end
if (:INSURANCE_PAYMENT = 899.46) then
begin
  K1 = 1.82;
  K2 = 2.2;
  K3 = 1.3;
  K4 = 1.2;
  ID_AUTO_CATEGORY = 6;
  ID_PLACE_ZONE = 5;
  ID_PRIVILEGE = 0;
end
if (:INSURANCE_PAYMENT = 613.27) then
begin
  K1 = 1.82;
  K2 = 1.5;
  K3 = 1.3;
  K4 = 1.2;
  ID_AUTO_CATEGORY = 6;
  ID_PLACE_ZONE = 6;
  ID_PRIVILEGE = 0;
end
if (:INSURANCE_PAYMENT = 1226.53) then
begin
  K1 = 1.82;
  K2 = 3;
  K3 = 1.3;
  K4 = 1.2;
  ID_AUTO_CATEGORY = 6;
  ID_PLACE_ZONE = 7;
  ID_PRIVILEGE = 0;
end
--4ю(конец)
/**/

--5ю
if (:INSURANCE_PAYMENT = 282.01) then
begin
  K1 = 0.34;
  K2 = 4.8;
  K3 = 1;
  K4 = 1.2;
  ID_AUTO_CATEGORY = 12;
  ID_PLACE_ZONE = 1;
  ID_PRIVILEGE = 0;
end
if (:INSURANCE_PAYMENT = 146.88) then
begin
  K1 = 0.34;
  K2 = 2.5;
  K3 = 1;
  K4 = 1.2;
  ID_AUTO_CATEGORY = 12;
  ID_PLACE_ZONE = 2;
  ID_PRIVILEGE = 0;
end
if (:INSURANCE_PAYMENT = 199.76) then
begin
  K1 = 0.34;
  K2 = 3.4;
  K3 = 1;
  K4 = 1.2;
  ID_AUTO_CATEGORY = 12;
  ID_PLACE_ZONE = 3;
  ID_PRIVILEGE = 0;
end
if (:INSURANCE_PAYMENT = 164.51) then
begin
  K1 = 0.34;
  K2 = 2.8;
  K3 = 1;
  K4 = 1.2;
  ID_AUTO_CATEGORY = 12;
  ID_PLACE_ZONE = 4;
  ID_PRIVILEGE = 0;
end
if (:INSURANCE_PAYMENT = 129.25) then
begin
  K1 = 0.34;
  K2 = 2.2;
  K3 = 1;
  K4 = 1.2;
  ID_AUTO_CATEGORY = 12;
  ID_PLACE_ZONE = 5;
  ID_PRIVILEGE = 0;
end
if (:INSURANCE_PAYMENT = 88.13) then
begin
  K1 = 0.34;
  K2 = 1.5;
  K3 = 1;
  K4 = 1.2;
  ID_AUTO_CATEGORY = 12;
  ID_PLACE_ZONE = 6;
  ID_PRIVILEGE = 0;
end
if (:INSURANCE_PAYMENT = 176.26) then
begin
  K1 = 0.34;
  K2 = 3;
  K3 = 1;
  K4 = 1.2;
  ID_AUTO_CATEGORY = 12;
  ID_PLACE_ZONE = 7;
  ID_PRIVILEGE = 0;
end
--5ю(конец)
/**/

--6ю
if (:INSURANCE_PAYMENT = 1480.55) then
begin
  K1 = 2.55;
  K2 = 4.8;
  K3 = 1;
  K4 = 1.2;
  ID_AUTO_CATEGORY = 9;
  ID_PLACE_ZONE = 1;
  ID_PRIVILEGE = 0;
  end_date_doc = dateadd(6 month TO :DATE_DOC) - 1;
end
if (:INSURANCE_PAYMENT = 771.12) then
begin
  K1 = 2.55;
  K2 = 2.5;
  K3 = 1;
  K4 = 1.2;
  ID_AUTO_CATEGORY = 9;
  ID_PLACE_ZONE = 2;
  ID_PRIVILEGE = 0;
  end_date_doc = dateadd(6 month TO :DATE_DOC) - 1;
end
if (:INSURANCE_PAYMENT = 1048.72) then
begin
  K1 = 2.55;
  K2 = 3.4;
  K3 = 1;
  K4 = 1.2;
  ID_AUTO_CATEGORY = 9;
  ID_PLACE_ZONE = 3;
  ID_PRIVILEGE = 0;
  end_date_doc = dateadd(6 month TO :DATE_DOC) - 1;
end
if (:INSURANCE_PAYMENT = 863.65) then
begin
  K1 = 2.55;
  K2 = 2.8;
  K3 = 1;
  K4 = 1.2;
  ID_AUTO_CATEGORY = 9;
  ID_PLACE_ZONE = 4;
  ID_PRIVILEGE = 0;
  end_date_doc = dateadd(6 month TO :DATE_DOC) - 1;
end
if (:INSURANCE_PAYMENT = 678.59) then
begin
  K1 = 2.55;
  K2 = 2.2;
  K3 = 1;
  K4 = 1.2;
  ID_AUTO_CATEGORY = 9;
  ID_PLACE_ZONE = 5;
  ID_PRIVILEGE = 0;
  end_date_doc = dateadd(6 month TO :DATE_DOC) - 1;
end
if (:INSURANCE_PAYMENT = 462.67) then
begin
  K1 = 2.55;
  K2 = 1.5;
  K3 = 1;
  K4 = 1.2;
  ID_AUTO_CATEGORY = 9;
  ID_PLACE_ZONE = 6;
  ID_PRIVILEGE = 0;
  end_date_doc = dateadd(6 month TO :DATE_DOC) - 1;
end
if (:INSURANCE_PAYMENT = 925.34) then
begin
  K1 = 2.55;
  K2 = 3;
  K3 = 1;
  K4 = 1.2;
  ID_AUTO_CATEGORY = 9;
  ID_PLACE_ZONE = 7;
  ID_PRIVILEGE = 0;
  end_date_doc = dateadd(6 month TO :DATE_DOC) - 1;
end
--6ю(конец)
/**/

--7ю
if (:INSURANCE_PAYMENT = 1741.82) then
begin
  K1 = 3;
  K2 = 4.8;
  K3 = 1;
  K4 = 1.2;
  ID_AUTO_CATEGORY = 10;
  ID_PLACE_ZONE = 1;
  ID_PRIVILEGE = 0;
  end_date_doc = dateadd(6 month TO :DATE_DOC) - 1;
end
if (:INSURANCE_PAYMENT = 907.20) then
begin
  K1 = 3;
  K2 = 2.5;
  K3 = 1;
  K4 = 1.2;
  ID_AUTO_CATEGORY = 10;
  ID_PLACE_ZONE = 2;
  ID_PRIVILEGE = 0;
  end_date_doc = dateadd(6 month TO :DATE_DOC) - 1;
end
if (:INSURANCE_PAYMENT = 1233.79) then
begin
  K1 = 3;
  K2 = 3.4;
  K3 = 1;
  K4 = 1.2;
  ID_AUTO_CATEGORY = 10;
  ID_PLACE_ZONE = 3;
  ID_PRIVILEGE = 0;
  end_date_doc = dateadd(6 month TO :DATE_DOC) - 1;
end
if (:INSURANCE_PAYMENT = 1016.06) then
begin
  K1 = 3;
  K2 = 2.8;
  K3 = 1;
  K4 = 1.2;
  ID_AUTO_CATEGORY = 10;
  ID_PLACE_ZONE = 4;
  ID_PRIVILEGE = 0;
  end_date_doc = dateadd(6 month TO :DATE_DOC) - 1;
end
if (:INSURANCE_PAYMENT = 798.34) then
begin
  K1 = 3;
  K2 = 2.2;
  K3 = 1;
  K4 = 1.2;
  ID_AUTO_CATEGORY = 10;
  ID_PLACE_ZONE = 5;
  ID_PRIVILEGE = 0;
  end_date_doc = dateadd(6 month TO :DATE_DOC) - 1;
end
if (:INSURANCE_PAYMENT = 544.32) then
begin
  K1 = 3;
  K2 = 1.5;
  K3 = 1;
  K4 = 1.2;
  ID_AUTO_CATEGORY = 10;
  ID_PLACE_ZONE = 6;
  ID_PRIVILEGE = 0;
  end_date_doc = dateadd(6 month TO :DATE_DOC) - 1;
end
if (:INSURANCE_PAYMENT = 1088.64) then
begin
  K1 = 3;
  K2 = 3;
  K3 = 1;
  K4 = 1.2;
  ID_AUTO_CATEGORY = 10;
  ID_PLACE_ZONE = 7;
  ID_PRIVILEGE = 0;
  end_date_doc = dateadd(6 month TO :DATE_DOC) - 1;
end
--7ю(конец)
/**/

--8ю
if (:INSURANCE_PAYMENT = 1658.88) then
begin
  K1 = 2;
  K2 = 4.8;
  K3 = 1;
  K4 = 1.2;
  ID_AUTO_CATEGORY = 7;
  ID_PLACE_ZONE = 1;
  ID_PRIVILEGE = 0;
end
if (:INSURANCE_PAYMENT = 864.00) then
begin
  K1 = 2;
  K2 = 2.5;
  K3 = 1;
  K4 = 1.2;
  ID_AUTO_CATEGORY = 7;
  ID_PLACE_ZONE = 2;
  ID_PRIVILEGE = 0;
end
if (:INSURANCE_PAYMENT = 1175.04) then
begin
  K1 = 2;
  K2 = 3.4;
  K3 = 1;
  K4 = 1.2;
  ID_AUTO_CATEGORY = 7;
  ID_PLACE_ZONE = 3;
  ID_PRIVILEGE = 0;
end
if (:INSURANCE_PAYMENT = 967.68) then
begin
  K1 = 2;
  K2 = 2.8;
  K3 = 1;
  K4 = 1.2;
  ID_AUTO_CATEGORY = 7;
  ID_PLACE_ZONE = 4;
  ID_PRIVILEGE = 0;
end
if (:INSURANCE_PAYMENT = 760.32) then
begin
  K1 = 2;
  K2 = 2.2;
  K3 = 1;
  K4 = 1.2;
  ID_AUTO_CATEGORY = 7;
  ID_PLACE_ZONE = 5;
  ID_PRIVILEGE = 0;
end
if (:INSURANCE_PAYMENT = 518.40) then
begin
  K1 = 2;
  K2 = 1.5;
  K3 = 1;
  K4 = 1.2;
  ID_AUTO_CATEGORY = 7;
  ID_PLACE_ZONE = 6;
  ID_PRIVILEGE = 0;
end
if (:INSURANCE_PAYMENT = 1071.36) then
begin
  K1 = 2;
  K2 = 3;
  K3 = 1;
  K4 = 1.2;
  ID_AUTO_CATEGORY = 7;
  ID_PLACE_ZONE = 7;
  ID_PRIVILEGE = 0;
end
--8ю(конец)
/**/

--9
if (:INSURANCE_PAYMENT = 1808.18) then
begin
  K1 = 2.18;
  K2 = 4.8;
  K3 = 1;
  K4 = 1.2;
  ID_AUTO_CATEGORY = 8;
  ID_PLACE_ZONE = 1;
  ID_PRIVILEGE = 0;
end
if (:INSURANCE_PAYMENT = 941.76) then
begin
  K1 = 2.18;
  K2 = 2.5;
  K3 = 1;
  K4 = 1.2;
  ID_AUTO_CATEGORY = 8;
  ID_PLACE_ZONE = 2;
  ID_PRIVILEGE = 0;
end
if (:INSURANCE_PAYMENT = 1280.79) then
begin
  K1 = 2.18;
  K2 = 3.4;
  K3 = 1;
  K4 = 1.2;
  ID_AUTO_CATEGORY = 8;
  ID_PLACE_ZONE = 3;
  ID_PRIVILEGE = 0;
end
if (:INSURANCE_PAYMENT = 1054.77) then
begin
  K1 = 2.18;
  K2 = 2.8;
  K3 = 1;
  K4 = 1.2;
  ID_AUTO_CATEGORY = 8;
  ID_PLACE_ZONE = 4;
  ID_PRIVILEGE = 0;
end
if (:INSURANCE_PAYMENT = 828.75) then
begin
  K1 = 2.18;
  K2 = 2.2;
  K3 = 1;
  K4 = 1.2;
  ID_AUTO_CATEGORY = 8;
  ID_PLACE_ZONE = 5;
  ID_PRIVILEGE = 0;
end
if (:INSURANCE_PAYMENT = 565.06) then
begin
  K1 = 2.18;
  K2 = 1.5;
  K3 = 1;
  K4 = 1.2;
  ID_AUTO_CATEGORY = 8;
  ID_PLACE_ZONE = 6;
  ID_PRIVILEGE = 0;
end
if (:INSURANCE_PAYMENT = 1130.11) then
begin
  K1 = 2.18;
  K2 = 3;
  K3 = 1;
  K4 = 1.2;
  ID_AUTO_CATEGORY = 8;
  ID_PLACE_ZONE = 7;
  ID_PRIVILEGE = 0;
end
--9ю(конец)
/**/

--10ю
if (:INSURANCE_PAYMENT = 414.72) then
begin
  K1 = 0.5;
  K2 = 4.8;
  K3 = 1;
  K4 = 1.2;
  ID_AUTO_CATEGORY = 11;
  ID_PLACE_ZONE = 1;
  ID_PRIVILEGE = 0;
end
if (:INSURANCE_PAYMENT = 216.00) then
begin
  K1 = 0.5;
  K2 = 2.5;
  K3 = 1;
  K4 = 1.2;
  ID_AUTO_CATEGORY = 11;
  ID_PLACE_ZONE = 2;
  ID_PRIVILEGE = 0;
end
if (:INSURANCE_PAYMENT = 293.76) then
begin
  K1 = 0.5;
  K2 = 3.4;
  K3 = 1;
  K4 = 1.2;
  ID_AUTO_CATEGORY = 11;
  ID_PLACE_ZONE = 3;
  ID_PRIVILEGE = 0;
end
if (:INSURANCE_PAYMENT = 241.92) then
begin
  K1 = 0.5;
  K2 = 2.8;
  K3 = 1;
  K4 = 1.2;
  ID_AUTO_CATEGORY = 11;
  ID_PLACE_ZONE = 4;
  ID_PRIVILEGE = 0;
end
if (:INSURANCE_PAYMENT = 190.08) then
begin
  K1 = 0.5;
  K2 = 2.2;
  K3 = 1;
  K4 = 1.2;
  ID_AUTO_CATEGORY = 11;
  ID_PLACE_ZONE = 5;
  ID_PRIVILEGE = 0;
end
if (:INSURANCE_PAYMENT = 129.60) then
begin
  K1 = 0.5;
  K2 = 1.5;
  K3 = 1;
  K4 = 1.2;
  ID_AUTO_CATEGORY = 11;
  ID_PLACE_ZONE = 6;
  ID_PRIVILEGE = 0;
end
if (:INSURANCE_PAYMENT = 259.20) then
begin
  K1 = 0.5;
  K2 = 3;
  K3 = 1;
  K4 = 1.2;
  ID_AUTO_CATEGORY = 11;
  ID_PLACE_ZONE = 7;
  ID_PRIVILEGE = 0;
end
--10ю(конец)
/**/

--11ю
if (:INSURANCE_PAYMENT = 366.61) then
begin
  K1 = 0.34;
  K2 = 4.8;
  K3 = 1.3;
  K4 = 1.2;
  ID_AUTO_CATEGORY = 1;
  ID_PLACE_ZONE = 1;
  ID_PRIVILEGE = 0;
end
if (:INSURANCE_PAYMENT = 190.94) then
begin
  K1 = 0.34;
  K2 = 2.5;
  K3 = 1.3;
  K4 = 1.2;
  ID_AUTO_CATEGORY = 1;
  ID_PLACE_ZONE = 2;
  ID_PRIVILEGE = 0;
end
if (:INSURANCE_PAYMENT = 259.68) then
begin
  K1 = 0.34;
  K2 = 3.4;
  K3 = 1.3;
  K4 = 1.2;
  ID_AUTO_CATEGORY = 1;
  ID_PLACE_ZONE = 3;
  ID_PRIVILEGE = 0;
end
if (:INSURANCE_PAYMENT = 213.86) then
begin
  K1 = 0.34;
  K2 = 2.8;
  K3 = 1.3;
  K4 = 1.2;
  ID_AUTO_CATEGORY = 1;
  ID_PLACE_ZONE = 4;
  ID_PRIVILEGE = 0;
end
if (:INSURANCE_PAYMENT = 168.03) then
begin
  K1 = 0.34;
  K2 = 2.2;
  K3 = 1.3;
  K4 = 1.2;
  ID_AUTO_CATEGORY = 1;
  ID_PLACE_ZONE = 5;
  ID_PRIVILEGE = 0;
end
if (:INSURANCE_PAYMENT = 114.57) then
begin
  K1 = 0.34;
  K2 = 1.5;
  K3 = 1.3;
  K4 = 1.2;
  ID_AUTO_CATEGORY = 1;
  ID_PLACE_ZONE = 6;
  ID_PRIVILEGE = 0;
end
if (:INSURANCE_PAYMENT = 229.13) then
begin
  K1 = 0.34;
  K2 = 3;
  K3 = 1.3;
  K4 = 1.2;
  ID_AUTO_CATEGORY = 1;
  ID_PLACE_ZONE = 7;
  ID_PRIVILEGE = 0;
end
--11ю(конец)
/**/

--12ю
if (:INSURANCE_PAYMENT = 733.22) then
begin
  K1 = 0.68;
  K2 = 4.8;
  K3 = 1.3;
  K4 = 1.2;
  ID_AUTO_CATEGORY = 2;
  ID_PLACE_ZONE = 1;
  ID_PRIVILEGE = 0;
end
if (:INSURANCE_PAYMENT = 381.89) then
begin
  K1 = 0.68;
  K2 = 2.5;
  K3 = 1.3;
  K4 = 1.2;
  ID_AUTO_CATEGORY = 2;
  ID_PLACE_ZONE = 2;
  ID_PRIVILEGE = 0;
end
if (:INSURANCE_PAYMENT = 519.37) then
begin
  K1 = 0.68;
  K2 = 3.4;
  K3 = 1.3;
  K4 = 1.2;
  ID_AUTO_CATEGORY = 2;
  ID_PLACE_ZONE = 3;
  ID_PRIVILEGE = 0;
end
if (:INSURANCE_PAYMENT = 427.71) then
begin
  K1 = 0.68;
  K2 = 2.8;
  K3 = 1.3;
  K4 = 1.2;
  ID_AUTO_CATEGORY = 2;
  ID_PLACE_ZONE = 4;
  ID_PRIVILEGE = 0;
end
if (:INSURANCE_PAYMENT = 336.06) then
begin
  K1 = 0.68;
  K2 = 2.2;
  K3 = 1.3;
  K4 = 1.2;
  ID_AUTO_CATEGORY = 2;
  ID_PLACE_ZONE = 5;
  ID_PRIVILEGE = 0;
end
if (:INSURANCE_PAYMENT = 229.13) then
begin
  K1 = 0.68;
  K2 = 1.5;
  K3 = 1.3;
  K4 = 1.2;
  ID_AUTO_CATEGORY = 2;
  ID_PLACE_ZONE = 6;
  ID_PRIVILEGE = 0;
end
if (:INSURANCE_PAYMENT = 458.27) then
begin
  K1 = 0.68;
  K2 = 3;
  K3 = 1.3;
  K4 = 1.2;
  ID_AUTO_CATEGORY = 2;
  ID_PLACE_ZONE = 7;
  ID_PRIVILEGE = 0;
end
--12ю(конец)
/**/ 
--Логика по суммам (конец)         

          --Вычисляем отчетный период (для D_DT_INS_POLICIES)
          REPORT_PERIOD = '01.'|| extract(MONTH from :date_doc)||'.'|| extract(YEAR from :date_doc);

          --Рассичтываем ТВП  
          INTERNAL_REINSURANCE = :INSURANCE_PAYMENT / 100 * 45;
          --Рассчитываем РВ
          RESERVE_PAYMENTS = INTERNAL_REINSURANCE / 100 * 80;
  
         --Генерация ID договора
          id_doc = gen_id(get_d_document, 1);
          ID_INSURANCE = gen_id(GEN_O_DT_INSURANCE_PARAMS_ID, 1); --ИД параметра
          ID_OBJ = gen_id(GEN_O_DT_INS_OBJ_ID, 1); --ИД обекта
        

         -- Создать страхователя для договора
          insert into d_dt_contract_customers (id_contract_customer, contract_customer_type, id_customer)
          values (gen_id(gen_d_dt_contract_customers_id, 1), 0, :id_customer)
          returning id_contract_customer
          into :id_contract_customer;

         -- Создать страховщика для договора
          insert into d_dt_contract_customers (id_contract_customer, contract_customer_type, id_customer, id_account, id_signer, id_signer_ground, id_signer_proxy)
          values (gen_id(gen_d_dt_contract_customers_id, 1), 1, 1, 3282, 96221, 1, 11631)
          returning id_contract_customer
          into :id_contract_customer_native;

          -- Создать выгодопреобретателя для договора
          insert into d_dt_contract_customers (id_contract_customer, contract_customer_type)
          values (gen_id(gen_d_dt_contract_customers_id, 1), 2)
          returning id_contract_customer
          into :ID_CONTRACT_BENEFICIARY;
    ------------------------------------------------------------------------------------------------------------
         -- Создание договора
           insert into d_dt_document
          (
            id_doc, num_doc, reg_num, date_doc, id_contract_customer_native,
            id_contract_customer, id_doc_type, id_doc_sub_type, id_blank, id_doc_inure_type,
            inure_date_doc, end_date_doc, contract_period, id_officer, id_division,
            id_status, id_state, id_conract_creator, id_conract_signer, memo,
            id_contract_stater, state_change_date, is_other_innure, other_date_doc, other_inure_date_doc,
            other_end_date_doc, id_doc_source, num_doc_changed, sign_change_date, id_registration_department
          )
          values 
          (
            :id_doc, :blank_number, :blank_number, :date_doc, :id_contract_customer_native,
            :id_contract_customer, 3, 0, :id_blank, 2,
            :DATE_DOC, :end_date_doc, DATEDIFF(DAY, :date_doc, :end_date_doc), :ID_OFFICER, 96,
            null, 1, 2509236, null, 'Генерация Ощадбанк '||:NOTE,
            64222, current_timestamp, iif(:closed_period >= :date_doc, 1, 0),
            iif(:closed_period >= :date_doc, maxvalue(:closed_period + 1, :date_doc), null),
            iif(:closed_period >= :date_doc, maxvalue(:closed_period + 1, :date_doc), null),
            iif(:closed_period >= :date_doc, maxvalue(:closed_period + 1, :end_date_doc), null), 3, 0, current_timestamp, 96
          );

          insert into d_dt_insurance (id_doc, id_ins_kind, rate_of_exchange, sum_doc, insurance_sum, bonus, id_sale_channel, insurance_year, credit_year, id_schedule_type, rate_of_exchange_euro, internal_reinsurance, reserve_payments, VALID_COST, ID_VALID_COST_CURRENCY, ID_INSURANCE_SUM_CURRENCY, ID_CONTRACT_BENEFICIARY)
          values (:id_doc, 51, (select  CR.RATE/100 from B_SP_CURRENCIES_RATE CR where CR.ID_CURRENCY_FROM = 840 and :date_doc between CR.ACTUAL_DATE_FROM and  cr.actual_date_to), :INSURANCE_PAYMENT, 300000, :BONUS, :id_sale_channel,
            1, 0, 2, (select  CR.RATE/100 from B_SP_CURRENCIES_RATE CR where CR.ID_CURRENCY_FROM = 978 and :date_doc between CR.ACTUAL_DATE_FROM and  cr.actual_date_to), :INTERNAL_REINSURANCE, :RESERVE_PAYMENTS, null, 980, 980, :ID_CONTRACT_BENEFICIARY
          );

          --Расширение договоров страхования для добровольной автогражданки      
          INSERT INTO D_DT_INS_COMMON_VCL (ID_DOC, CONTRACT_TYPE, ID_BASED_BY_POLICY, BASED_BY_POLICY_SER_NUM, BASED_BY_POLICY_DATE)
          VALUES (:id_doc, null, NULL, NULL, NULL);
          
         --Объекты      
          INSERT INTO O_DT_INS_OBJECTS
          (ID_OBJ, OBJ_NAME, OBJ_ITEM_NUM, ID_TYPE, ID_OWNER, ID_OWNER_OBJ, ID_OBJ_STATE, OBJ_VALID_COST, VALID_COST_CURRENCY, OBJ_INSURANCE_SUM, INSURANCE_SUM_CURRENCY, OBJ_FRANCHISE, OBJ_INSURANCE_TARIFF, OBJ_INSURANCE_PAYMENT, BONUS, LINK_TO, IS_EXPORTED, ERROR_1C)
          VALUES
          (:ID_OBJ, 'Автомобиль', NULL, 1, :ID_CUSTOMER, NULL, 20, NULL, NULL, NULL, NULL, null/*OBJ_FR*/, NULL, NULL, NULL, NULL, NULL, NULL);

          --Таблица информации по объекту страхования - автомобилю
          INSERT INTO O_DT_INS_AUTOS (ID_OBJ, ID_AUTO_CATEGORY)
          VALUES (:ID_OBJ, :ID_AUTO_CATEGORY);

         --Параметры страхования
         INSERT INTO O_DT_INSURANCE_PARAMS
           (ID_INSURANCE, ID_DOC, ID_OBJECT_BENEFICIARY, ID_OBJ, OBJECTS_COUNT, OBJ_ITEM_NUM, REAL_INSURANCE_SUM, ID_REAL_INS_SUM_CURRENCY, OBJ_VALID_COST, ID_OBJ_VALID_COST_CURRENCY, OBJ_INSURANCE_SUM, ID_OBJ_INSURANCE_SUM_CURRENCY, OBJ_CREDIT_AMOUNT, ID_OBJ_CREDIT_AMOUNT_CURRENCY, FRANCHISE_PER, FRANCHISE_CUR, FRANCHISE_MINIMUM, INSURANCE_TARIFF, CALC_INSURANCE_TARIFF, IS_DEPENDS_TARIFF_ON_COMM, INSURANCE_PAYMENT, INSURANCE_PAYMENT_CALC, ID_PACKAGE, IS_CHANGED_PACKAGE, ID_PARENT, ID_TARIFF_MEMBER, K_FAKE, K0, FRANCHISE, IS_REQUIRED_PROP_INT, CUST_PROP_INTEREST, LOADING, ORIGINAL_INSURANCE_TARIFF, ORIGINAL_INSURANCE_PAYMENT, IS_OVERPAY, INTERNAL_REINSURANCE_CUR, INTERNAL_REINSURANCE_PER, RESERVE_PAYMENTS_CUR, RESERVE_PAYMENTS_PER, K_PAYMENT_PARTITION, ID_PROGRAM, K_UNDERWRITING)
         VALUES
           (:ID_INSURANCE, :ID_DOC,  null, :ID_OBJ, 1, 1, NULL, NULL, null, NULL, 300000, NULL, NULL, NULL, null/*FR_PER*/, :FRANCHISE_CUR/*FR_CUR*/, null/*FR_MINIMUM*/, 180, :INSURANCE_PAYMENT/*будет рассчет*/, NULL, :INSURANCE_PAYMENT, null, 45, 0, NULL, :ID_TARIFF_MEMBER, 1, 1, null/*FR*/, null, NULL, :LOADING, 180, :INSURANCE_PAYMENT,   0, :INTERNAL_REINSURANCE, 55, :RESERVE_PAYMENTS, 0.19, 1, NULL, 1);

         --Тарифы для договора
         INSERT INTO D_DT_INSURANCE_TARIFFS (ID_INSURANCE_TARIFF, ID_OBJ, INSURANCE_YEAR, INSURANCE_TARIFF, INSURANCE_PAYMENT, INSURANCE_AMOUNT, ORIGINAL_INSURANCE_TARIFF, ORIGINAL_INSURANCE_PAYMENT, INTERNAL_REINSURANCE_CUR, INTERNAL_REINSURANCE_PER, RESERVE_PAYMENTS_CUR, RESERVE_PAYMENTS_PER) 
         VALUES (gen_id(GEN_ID_INSURANCE_TARIFF, 1), :ID_INSURANCE, EXTRACT(YEAR FROM :date_doc), :INSURANCE_PAYMENT/*будет рассчет*/, :INSURANCE_PAYMENT, 300000, NULL, NULL, :INTERNAL_REINSURANCE, 55, :RESERVE_PAYMENTS, 0.19);

         --Таблица параметров страхования для договоров го и полисов нет исторического триггера -
        INSERT INTO O_DT_INS_PARAM_COMMON_POLICY (ID_INSURANCE, LIFE_LIMIT, PROPERTY_LIMIT, WITH_POSTPONEMENT) VALUES (:ID_INSURANCE, 200000, 100000, NULL);

        --Таблица параметров страхования по объекту страхования (логика п коефициентам)
        INSERT INTO O_DT_INSURANCE_PARAMS_POLICY (ID_INSURANCE, K1, K2, K3, K4, K5, K6, K7, K8, IS_TRANSCRIBE, ID_REGISTRATION_PLACE, ID_PLACE_ZONE, ENABLED_CATEGORIES, AUTO_USAGE_MONTHS, AUTO_USED_AS_TAXI, OTK_REQUIRED, NEXT_OTK_DATE, EXPERIENCE_LESS_3_YEARS, ID_AUTO_CATEGORY, FRANCHISE_FOR_TARIFF_CUR, IS_AVAILABILITY_VCL)
        VALUES (:ID_INSURANCE, :K1, :K2, :K3, :K4, :K5, :K6, :K7, :BONUS, 0, NULL, :ID_PLACE_ZONE, NULL, '000000000000', NULL, 0, NULL, NULL, :ID_AUTO_CATEGORY, null/*FR_FOR_TARIFF_CUR*/, NULL);

        --Информация по объекту договора - полису
         INSERT INTO D_DT_INS_POLICIES (ID_DOC, ID_LOT_POLICY, STICKER, TRANSCRIBE_TYPE, ID_TRANSCRIBE_POLICY, TRANS_POLICY_STRING, TRANS_POLICY_INURE_DATE, TRANS_POLICY_END_DATE, TRANS_POLICY_DISSOL_DATE, TRANS_POLICY_SUM, ALLOW_LEAP_YEAR, CUR_RECORD_STATUS, REPORT_PERIOD, ID_PRIVILEGE, ID_DOCUMENT_PAYMENT, CONTRACT_TYPE, IS_EXPORTED_MTSBU, ID_PRIVILEGE_DOCUMENT, ID_AUTO_REGISTRATION_TYPE, REGISTRATION_EXPIRE_DATE, TRANSCRIBE_KIND)
         VALUES (:id_doc, NULL, '', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, :REPORT_PERIOD, :ID_PRIVILEGE, NULL, 1, NULL, NULL, 1, NULL, 0);

        --Таблица агентов по договорам (по коду агента)
        INSERT INTO D_DT_AGENTS (ID_DOC_AGENT, ID_DOC, ID_AGENT, ID_COMMISSION_TYPE, COMMISSION, ID_AGENT_CONTRACT, ID_AGENT_ORDER)
         VALUES (gen_id(GEN_D_DT_AGENTS_ID, 1), :id_doc, 559, 0, 15, null, 4);

        --Таблица агентов по договорам (по агентскому соглашению)
        INSERT INTO D_DT_AGENTS (ID_DOC_AGENT, ID_DOC, ID_AGENT, ID_COMMISSION_TYPE, COMMISSION, ID_AGENT_CONTRACT, ID_AGENT_ORDER)
         VALUES (gen_id(GEN_D_DT_AGENTS_ID, 1), :id_doc, null, 0, 20, 3847707, 1);

          --Плановый платеж
        INSERT INTO d_dt_schedules (ID_SCHEDULE, ID_DOC_INFO, SCHEDULE_DATE, SCHEDULE_SUM, ID_SCHEDULE_TYPE, BALANCE_SUM, ID_FACT_PAYMENT, IS_LAST_IN_DAY) 
         VALUES (gen_id(GET_D_SCHEDULE, 1), :ID_DOC, :DATE_DOC, :INSURANCE_PAYMENT, 0, null, NULL, 1);

             --Обновление временной таблицы
        update T_TEMP_TABLE TT
        set tt.INT_FIELD6 = :id_doc
        where TT.INT_FIELD1 = :TEMP_KEY and
              TT.INT_FIELD2 = :ID_NUMBER;

    --end
    end
end


/* --Проверка
select
t.INT_FIELD6 as ID_DOC,      --ID договора
t.DATE_FIELD1 as DATE_DOC,
t.DATE_FIELD2 as INURE_DATE_DOC, --CONTRACT_ENTRY_DATE,
t.CURR_FIELD1 as FACT_SUM,
--t.INT_FIELD1,
t.INT_FIELD2 as ID_PAYMENT,
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