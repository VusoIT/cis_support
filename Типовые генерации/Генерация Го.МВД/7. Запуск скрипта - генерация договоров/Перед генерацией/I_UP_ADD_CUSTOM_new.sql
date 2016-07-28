create or alter procedure I_UP_ADD_CUSTOM (
    OPERATION_ID integer,
    OPERATION_KIND varchar(100),
    ALLOW_SEARCH integer,
    VALIDATED integer,
    RECREATED integer,
    ID_IMPORT_TYPE integer,
    ID_DOC integer,
    ID_DOC_TYPE integer,
    REG_NUM varchar(1000),
    POLICY_SERIES varchar(3),
    POLICY_NUMBER varchar(8),
    STICKER_SERIES varchar(3),
    STICKER_NUMBER varchar(8),
    DATE_DOC timestamp,
    INURE_DATE_DOC timestamp,
    END_DATE_DOC timestamp,
    ARCH_NUM_DOC varchar(1000),
    DISCOUNT numeric(18,10),
    ID_PRIVILEGE integer,
    BONUS numeric(18,10),
    OWN_INSURANCE_PAYMENT varchar(100),
    REAL_INSURANCE_PAYMENT numeric(18,10),
    REAL_INSURANCE_TARIFF numeric(18,10),
    REAL_INSURANCE_SUM numeric(18,10),
    INSURANCE_YEAR integer,
    MEMO varchar(1000),
    POLICY_TYPE integer,
    ID_BENEFICIARY integer,
    ID_BENEFICIARY_TYPE integer,
    BENEFICIARY_CODE varchar(1000),
    BENEFICIARY_NAME varchar(1000),
    BENEFICIARY_ID_PLACE integer,
    BENEFICIARY_PLACE_NAME varchar(100),
    BENEFICIARY_ADDRESS_STREET varchar(100),
    BENEFICIARY_ADDRESS_HOUSE varchar(100),
    BENEFICIARY_ADDRESS_FLAT varchar(100),
    BENEFICIARY_POST varchar(100),
    ID_OFFICER integer,
    OFFICER_CODE varchar(1000),
    OFFICER_NAME varchar(1000),
    ID_FINANC_CONSULTANT integer,
    FINANC_CONSULTANT_CODE varchar(1000),
    FINANC_CONSULTANT_NAME varchar(1000),
    ID_DEPART_MANAGER integer,
    DEPART_MANAGER_CODE varchar(1000),
    DEPART_MANAGER_NAME varchar(1000),
    ID_RESPONS_DISC integer,
    RESPONS_DISC_CODE varchar(1000),
    RESPONS_DISC_NAME varchar(1000),
    ID_CONTRACT_NATIVE_SIGNER integer,
    ID_DEPARTMENT integer,
    DEPARTMENT_CODE varchar(1000),
    DEPARTMENT_NAME varchar(1000),
    INS_KIND_CODE varchar(1000),
    INS_KIND_NAME type of column B_SP_INS_KIND.NAME_INS_KIND,
    SALE_CHANNEL_NAME varchar(1000),
    DOC_INURE_TYPE_NAME varchar(1000),
    ID_MEMORANDUM integer,
    REGISTRATION_ID_PLACE integer,
    REGISTRATION_PLACE_NAME varchar(100),
    REGISTRATION_REGION_CODE varchar(2),
    REGISTRATION_REGION_NAME varchar(810),
    ENABLED_CATEGORY_A integer,
    ENABLED_CATEGORY_B integer,
    ENABLED_CATEGORY_C integer,
    ENABLED_CATEGORY_D integer,
    ENABLED_CATEGORY_E integer,
    ENABLED_CATEGORY_F integer,
    ID_CUSTOMER integer,
    ID_CUSTOMER_1C varchar(10),
    ID_CUSTOMER_TYPE integer,
    CUSTOMER_CODE varchar(1000),
    CUSTOMER_NAME varchar(1000),
    CUSTOMER_BIRTH_DATE timestamp,
    CUSTOMER_ADDRESS varchar(500),
    CUSTOMER_ADDRESS_COUNTRY_ID integer,
    CUSTOMER_ID_PLACE integer,
    CUSTOMER_PLACE_NAME varchar(100),
    CUSTOMER_PLACE_TYPE integer,
    CUSTOMER_REGION_CODE varchar(2),
    CUSTOMER_REGION_NAME varchar(810),
    CUSTOMER_ADDRESS_STREET varchar(100),
    CUSTOMER_ADDRESS_HOUSE varchar(100),
    CUSTOMER_ADDRESS_FLAT varchar(100),
    CUSTOMER_POST varchar(100),
    CUSTOMER_PHONE varchar(15),
    CUSTOMER_REGISTRTION_CODE integer,
    CUSTOMER_DRIVER_EXPER_YEAR integer,
    CUSTOMER_SERIES_DRIVER_DOC varchar(10),
    CUSTOMER_NUMBER_DRIVER_DOC varchar(10),
    CUSTOMER_SERIES_PRIVILAGE_DOC varchar(10),
    CUSTOMER_NUMBER_PRIVILAGE_DOC varchar(10),
    CUSTOMER_SERIES_INT_PASS varchar(2),
    CUSTOMER_NUMBER_INT_PASS varchar(6),
    CUSTOMER_SERIES_UKR_PASS varchar(2),
    CUSTOMER_NUMBER_UKR_PASS varchar(6),
    CUSTOMER_SERIES_FOR_PASS varchar(5),
    CUSTOMER_NUMBER_FOR_PASS varchar(10),
    ID_INSURED integer,
    ID_INSURED_TYPE integer,
    INSURED_CODE varchar(1000),
    INSURED_NAME varchar(1000),
    INSURED_BIRTH_DATE timestamp,
    INSURED_ADDRESS varchar(500),
    INSURED_ADDRESS_COUNTRY_ID integer,
    INSURED_ID_PLACE integer,
    INSURED_PLACE_NAME varchar(100),
    INSURED_PLACE_TYPE integer,
    INSURED_REGION_CODE varchar(2),
    INSURED_REGION_NAME varchar(810),
    INSURED_ADDRESS_STREET varchar(100),
    INSURED_ADDRESS_HOUSE varchar(100),
    INSURED_ADDRESS_FLAT varchar(100),
    INSURED_POST varchar(100),
    INSURED_PHONE varchar(15),
    INSURED_DRIVER_EXPER_YEAR integer,
    INSURED_SERIES_DRIVER_DOC varchar(10),
    INSURED_NUMBER_DRIVER_DOC varchar(10),
    INSURED_SERIES_PRIVILAGE_DOC varchar(10),
    INSURED_NUMBER_PRIVILAGE_DOC varchar(10),
    INSURED_SERIES_INT_PASS varchar(2),
    INSURED_NUMBER_INT_PASS varchar(6),
    INSURED_SERIES_UKR_PASS varchar(2),
    INSURED_NUMBER_UKR_PASS varchar(6),
    INSURED_SERIES_FOR_PASS varchar(5),
    INSURED_NUMBER_FOR_PASS varchar(10),
    ID_INSURED_PROGRAM integer,
    NAME_INSURED_PROGRAM varchar(100),
    DRIVER_NAME_1 varchar(810),
    SERIES_DRIVER_DOC_1 varchar(10),
    NUMBER_DRIVER_DOC_1 varchar(10),
    DRIVER_EXPER_YEAR_1 integer,
    DRIVER_NAME_2 varchar(810),
    SERIES_DRIVER_DOC_2 varchar(10),
    NUMBER_DRIVER_DOC_2 varchar(10),
    DRIVER_EXPER_YEAR_2 integer,
    DRIVER_NAME_3 varchar(810),
    SERIES_DRIVER_DOC_3 varchar(10),
    NUMBER_DRIVER_DOC_3 varchar(10),
    DRIVER_EXPER_YEAR_3 integer,
    DRIVER_NAME_4 varchar(810),
    SERIES_DRIVER_DOC_4 varchar(10),
    NUMBER_DRIVER_DOC_4 varchar(10),
    DRIVER_EXPER_YEAR_4 integer,
    CUSTOMER_CUST_MEMO_1 varchar(1000),
    CUSTOMER_CUST_MEMO_2 varchar(1000),
    CUSTOMER_CUST_MEMO_3 varchar(1000),
    CUSTOMER_CUST_MEMO_4 varchar(1000),
    CUSTOMER_CUST_MEMO_5 varchar(1000),
    CUSTOMER_CUST_MEMO_6 varchar(1000),
    LIFE_LIMIT numeric(18,10),
    PROPERTY_LIMIT numeric(18,10),
    FRANCHISE numeric(18,10),
    OBJECTS_ID_TARIFF integer,
    OBJECTS_PACKAGE integer,
    OBJECTS_INSURANCE_TARIFF_CALC numeric(18,10),
    OBJECTS_INSURANCE_TARIFF numeric(18,10),
    OBJECTS_INSURANCE_PAYMENT numeric(18,10),
    OBJECTS_INSURANCE_SUM numeric(18,10),
    OBJECTS_LOADING numeric(5,2),
    OBJECTS_AUTO_UNUSE_MOUNTH varchar(12),
    OBJECTS_AUTO_REG_TYPE_ID integer,
    OBJECTS_AUTO_REG_DATE date,
    OBJECTS_AUTO_TAXI integer,
    OBJECTS_AUTO_3EXP integer,
    OBJECTS_K_FAKE numeric(18,10),
    OBJECTS_K0 numeric(18,10),
    OBJECTS_K1 numeric(18,10),
    OBJECTS_K2 numeric(18,10),
    OBJECTS_K3 numeric(18,10),
    OBJECTS_K4 numeric(18,10),
    OBJECTS_K5 numeric(18,10),
    OBJECTS_K6 numeric(18,10),
    OBJECTS_K7 numeric(18,10),
    OBJECTS_K8 numeric(18,10),
    OBJECTS_AUTO_MODEL varchar(100),
    OBJECTS_AUTO_NUMBER varchar(20),
    OBJECTS_AUTO_BODY_NUMBER varchar(40),
    OBJECTS_AUTO_MANUFACT_YEAR integer,
    OBJECTS_AUTO_MANUFACT_MONTH integer,
    OBJECTS_AUTO_MANUFACT_MONTH_COR integer,
    OBJECTS_AUTO_ENGINE_VOLUME numeric(5,2),
    OBJECTS_AUTO_CATEGORY_CODE varchar(2),
    SHEDULES_ID_SCHELULE_TYPE integer,
    SHEDULES_SCHEDULE_DATE timestamp,
    AGENT_COMMISSIONS_AGENT_1 varchar(1000),
    AGENT_COMMISSIONS_AGENT_2 varchar(1000),
    AGENT_COMMISSIONS_AGENT_3 varchar(1000),
    AGENT_COMMISSIONS_AGENT_4 varchar(1000),
    AGENT_COMMISSIONS_AGENT_5 varchar(1000),
    AGENT_CONTRACT_NAME varchar(1000),
    GENERAL_CONTRACT_NUMBER varchar(100),
    GENERAL_CONTRACT_DATE timestamp,
    RECALC_GENERAL_CONTRACT_SUM integer,
    SPECIAL_CONDITIONS_ID integer,
    TERRITORY_OF_ACTION_ID integer,
    DESTINATION_COUNTRY_ID integer,
    PERIOD_ABROAD_TOTAL integer,
    PERIOD_ABROAD_PER_ONE integer,
    ID_DOC_SOURCE type of column D_INI_DOC_SOURCE.ID_DOC_SOURCE,
    IS_MULTIVISA integer,
    LOYAL_CUSTOMERS integer,
    ID_INS_CURRENCY integer,
    IS_FAMILY_OR_GROUP integer,
    GROUP_COUNT integer,
    ID_MED_INS_CURRENCY integer,
    MED_INS_SUM numeric(18,10),
    MED_INS_TARIFF numeric(18,10),
    MED_INS_PAYM numeric(18,10),
    ID_ACCID_INS_CURRENCY integer,
    ACCID_INS_SUM numeric(18,10),
    ACCID_INS_TARIFF numeric(18,10),
    ACCID_INS_PAYM numeric(18,10),
    ID_BAGAGE_INS_CURRENCY integer,
    BAGAGE_INS_SUM numeric(18,10),
    BAGAGE_INS_TARIFF numeric(18,10),
    BAGAGE_INS_PAYM numeric(18,10),
    AGE integer,
    EXT_NUM varchar(1000),
    OBJECTS_CONTRACT_NUM varchar(1000),
    OBJECTS_CONTRACT_DATE date,
    ID_NATIVE_ACCOUNT integer,
    ID_BENEFICIARY_ACCOUNT integer,
    ID_CONTRACT_NATIVE_SIGNER_GRD integer,
    ID_CONTRACT_NATIVE_SIGNER_PROXY integer)
returns (
    RESULT varchar(1000))
as
declare variable CONST_MVD varchar(50);
declare variable CONST_GENERATE varchar(50);
declare variable OK varchar(50);
declare variable ERR varchar(800);
declare variable ERROR_CONTRACT_EXIST varchar(50);
declare variable ERROR_OTHER_CONTRACT_EXIST varchar(50);
declare variable WARNING_CONTRACT_EXIST varchar(50);
declare variable ERROR_NOT_BLANK varchar(50);
declare variable ERROR_BLANK_NOT_CLEAN varchar(50);
declare variable ERROR_NOT_CUSTOMER_TYPE varchar(50);
declare variable ERROR_NOT_PERSON_TYPE varchar(50);
declare variable ERROR_NOT_CUSTOMER_NAME varchar(50);
declare variable ERROR_NOT_INSURED_NAME varchar(50);
declare variable WARNING_NOT_FIND_BENEFICIARY varchar(50);
declare variable ERROR_NOT_FIND_INURE_TYPE varchar(50);
declare variable ERROR_NOT_FIND_OFFICER varchar(50);
declare variable WARNING_NOT_FIND_FINANC_CONSULTANT varchar(50);
declare variable WARNING_NOT_FIND_DEPART_MANAGER varchar(50);
declare variable WARNING_NOT_FIND_RESPONS_DISC varchar(50);
declare variable ERROR_NOT_FIND_DEPARTMENT varchar(50);
declare variable ERROR_NOT_FIND_INS_KIND varchar(50);
declare variable ERROR_NOT_FIND_SALE_CHANNEL varchar(50);
declare variable WARNING_NOT_FIND_AGENT_CONTRACT varchar(50);
declare variable I integer;
declare variable CNT integer;
declare variable CONTRACT_CNT integer;
declare variable END_STRING char(1);
declare variable CLOSED_PERIOD date;
declare variable OTHER_DATE_DOC date;
declare variable OTHER_INURE_DATE_DOC timestamp;
declare variable OTHER_END_DATE_DOC timestamp;
declare variable ID_BLANK integer;
declare variable ID_BLANK_STATE integer;
declare variable ID_STICKER integer;
declare variable ID_CONTRACT_CUSTOMER integer;
declare variable CONTRACT_CUSTOMER_TYPE integer;
declare variable ID_NATIVE_CUSTOMER integer;
declare variable ID_CONTRACT_NATIVE_CUSTOMER integer;
declare variable CONTRACT_NATIVE_CUSTOMER_TYPE integer;
declare variable ID_CONTRACT_BENEFICIARY integer;
declare variable CONTRACT_BENEFICIARY_TYPE integer;
declare variable ID_DOC_SUB_TYPE integer;
declare variable ID_STATE integer;
declare variable ID_STATUS integer;
declare variable ID_CONTRACT_CREATOR integer;
declare variable ID_CONTRACT_SIGNER integer;
declare variable ID_CONTRACT_ACCEPTOR integer;
declare variable ID_CONTRACT_STATER integer;
declare variable STATE_CHANGE_DATE timestamp;
declare variable ID_DOC_INURE_TYPE integer;
declare variable IS_OTHER_INNURE integer;
declare variable ID_INS_KIND integer;
declare variable ID_SALE_CHANNEL integer;
declare variable CONTRACT_MEMO TTEXTBLOB;
declare variable CUSTUMER_MEMO varchar(400);
declare variable ID_INSURANCE integer;
declare variable OBJECTS_COUNT integer;
declare variable IS_CHANGED_PACKAGE integer;
declare variable OBJECT_NUMBER integer;
declare variable INSURANCE_AMOUNT numeric(15,2);
declare variable VALID_COST numeric(15,2);
declare variable INSURANCE_PAYMENT numeric(15,2);
declare variable ID_SCHEDULE integer;
declare variable ID_DOC_AGENT integer;
declare variable ID_AGENT integer;
declare variable ID_SALE_POINT integer;
declare variable ID_SALE_POINT_CUSTOMER integer;
declare variable AGENT_COMISSION numeric(9,4);
declare variable AGENT_COMISSION_TYPE integer;
declare variable AGENT_CODE varchar(20);
declare variable ID_AGENT_CONTRACT integer;
declare variable STICKER varchar(100);
declare variable ID_OBJECT integer;
declare variable ID_LOT_POLICY integer;
declare variable GENERAL_CONTRACT_SUM numeric(15,2);
declare variable OBJECTS_INSURANCE_PAYMENT_CALC numeric(15,2);
declare variable K integer;
declare variable ID_AGENT_DOC integer;
declare variable ORIGINAL_INS_TARIFF TNUMERIC16_2;
declare variable ORIGINAL_INS_PAYMENT TNUMERIC16_2;
declare variable NUM_DOC_CHANGED TBOOLEAN_EX;
declare variable NUM_DOC varchar(1000);
declare variable ID_DEP TINTEGER;
declare variable ID_DEP_LIST varchar(1000);
begin
--- Определение констант
CONST_MVD = '_MVD_';
CONST_GENERATE = '_GENERATE_';
-- константы ошибок --
OK = 'OK';
ERR = 'ERR';
ERROR_CONTRACT_EXIST = 'договор уже существует (в состянии "не черновик")';
ERROR_OTHER_CONTRACT_EXIST = 'договор уже существует и он другого типа!';
WARNING_CONTRACT_EXIST = 'договор уже существует, но будет перезаписан';
ERROR_NOT_BLANK = 'бланк не найден в системе';
ERROR_BLANK_NOT_CLEAN = 'бланк должен находиться в состоянии "чистый"';
ERROR_NOT_CUSTOMER_TYPE = 'не задан тип страхователя';
ERROR_NOT_PERSON_TYPE = 'не задан тип личности';
ERROR_NOT_CUSTOMER_NAME = 'не задано наименование страхователя';
ERROR_NOT_INSURED_NAME = 'не задано наименование личности';
WARNING_NOT_FIND_BENEFICIARY = 'выгодоприобретателя не найден в системе';
ERROR_NOT_FIND_INURE_TYPE = 'тип вступления не найден в системе';
ERROR_NOT_FIND_OFFICER = 'ответственный исполнитель не найден в системе';
WARNING_NOT_FIND_FINANC_CONSULTANT = 'финансовый консультант не найден в системе';
WARNING_NOT_FIND_DEPART_MANAGER = 'руководитель подразделения не найден в системе';
WARNING_NOT_FIND_RESPONS_DISC = 'ответственный за скидку не найден в системе';
ERROR_NOT_FIND_DEPARTMENT = 'подразделение не найдено в системе';
ERROR_NOT_FIND_INS_KIND = 'вид страхования не найдено в системе';
ERROR_NOT_FIND_SALE_CHANNEL = 'канал продаж не найден в системе';
WARNING_NOT_FIND_AGENT_CONTRACT = 'агентское соглашение не найдено в системе';
--
if (:objects_id_tariff is not null and :objects_package is null) then
begin
 select first 1 tm.id_tariff_member
 from p_sp_tariff_members tm
 where tm.id_tariff = :objects_id_tariff
 into :objects_package;
end
--- определение типа операции ---
if (:objects_package in (20660,20661,20662,
 4167,4168,4169,4261,4261,4262,4263,4251,4254,4255,4256,4180,4227,4166,4170,
 4170,4265,4244,4245,4246,4248,4247,4249,4316,4317,4318,4321,4320,4319,4322,
 4310,4311,4312,4315,4314,4313,4309,4308,4250,4326,4325,4279,4281,4280,4282))
then
  operation_kind = coalesce(:operation_kind,'') || :const_mvd;
-- проверки
if (id_doc_type = 8) then exception s_exception 'Неверный тип договора для паспорта (8)!';
if ((id_doc_type = 7) and (not (id_import_type in (33, 34)))) then exception s_exception 'Неверный тип договора для паспорта (7)!';
if (:date_doc is null) then exception s_exception 'Не задана дата договора';
if (:end_date_doc is null) then exception s_exception 'Не задана дата окончания договора';
if (:inure_date_doc is null) then exception s_exception 'Не задана дата вступления договора';
if (coalesce(:customer_name, '') = '') then exception s_exception 'Не задан контрагент';
select rdb$set_context('USER_SESSION', 'EXPORT_IGNORE', 1) from sys_options into :k;
--- Установка переменных
allow_search = coalesce(:allow_search, 1);
--recreated = 1;
recreated = coalesce(:recreated, 0);
id_ins_currency = coalesce(:id_ins_currency, 980);  -- гривня
end_string = ascii_char(10);
if (coalesce(:reg_num,'') = '') then reg_num = null;
if (coalesce(:num_doc,'') = '') then num_doc = null;
if (coalesce(:ext_num,'') = '') then ext_num = null;
if ((:id_doc_type is null) and not (:id_import_type is null)) then
 if (:id_import_type = 21) then id_doc_type = 3;  else -- ВУСО ОСАГО
 if (:id_import_type = 22) then id_doc_type = 38; else -- ВУСО ВЗР МВД
 if (:id_import_type = 23) then id_doc_type = 6;  else -- ВУСО НС МВД
 if (:id_import_type = 24) then id_doc_type = 22; else -- ВУСО ОТЛ МВД
 if (:id_import_type = 25) then id_doc_type = 5;  else -- ВУСО ИМУЩЕСТВО (паспорт) МВД
 if (:id_import_type = 26) then id_doc_type = 16; else -- ВУСО МЕД МВД
 if (:id_import_type = 27) then id_doc_type = 6;  else -- ВУСО НС Классика
 if (:id_import_type = 28) then id_doc_type = 6;  else -- ЕУРОПА НС Классика
 if (:id_import_type = 29) then id_doc_type = 39; else -- ЕУРОПА-ЖИТТЯ НС Классика
 if (:id_import_type = 30) then id_doc_type = 12; else -- ЕУРОПА Кредиты
 if (:id_import_type = 31) then id_doc_type = 12; else -- ЕУРОПА Депозиты
 if (:id_import_type = 32) then id_doc_type = 40; else -- ЕУРОПА компл им
   id_doc_type = -1; -- ошибка
-- удаляем договор
if (:operation_id = 1) then
begin
if (:id_doc is null and not :reg_num is null) then
begin
 select count(d.id_doc)
   from d_dt_document d
  where upper(d.reg_num) like upper(:reg_num) || '%'
    and d.id_doc_type = :id_doc_type
    and d.id_state <> 5
   into :cnt;
 if (:cnt = 1) then
 begin
   select d.id_doc
     from d_dt_document d
    where upper(d.reg_num) like upper(:reg_num) || '%'
      and d.id_doc_type = :id_doc_type
      and d.id_state <> 5
     into :id_doc;
 end
end
if (:id_doc is null) then exit;
for
  select ip.id_insurance
    from o_dt_insurance_params ip
   where id_doc = :id_doc
    into :id_insurance
do
begin
 delete from d_dt_re_objects where id_ins_doc = :id_doc;
 delete from d_dt_re_objects where id_ins_object = :id_insurance;
 select id_obj from o_dt_insurance_params where id_doc = :id_doc into :id_object;
 select id_contract_customer from d_dt_document where id_doc = :id_doc into :id_contract_customer;
 select id_contract_customer_native from d_dt_document where id_doc = :id_doc into :id_contract_native_customer;
 select id_contract_beneficiary from d_dt_insurance where id_doc = :id_doc into :id_contract_beneficiary;
 delete from d_ins_obj_risk_franchise where id_obj = :id_insurance;
 delete from d_dt_insurance_tariffs where id_obj = :id_insurance;
 delete from o_dt_policy_auto_users where id_insurance_param = :id_insurance;
 delete from o_dt_insurance_params_policy where id_insurance = :id_insurance;
 delete from o_dt_ins_param_common_policy where id_insurance = :id_insurance;
 delete from o_dt_insurance_params_ns where id_insurance = :id_insurance;
 delete from o_dt_insurance_params_green where id_insurance = :id_insurance;
 delete from o_dt_insurance_params_other where id_insurance = :id_insurance;
 delete from o_dt_insurance_params where id_insurance = :id_insurance;
 select count(id_insurance)
   from o_dt_insurance_params
  where id_obj = :id_object
   into :cnt;
 if (:cnt = 0) then
 begin
   delete from o_dt_auto_reg_certificates where id_auto = :id_object;
   delete from o_dt_ins_autos             where id_obj = :id_object;
   delete from o_dt_ins_persons           where id_obj = :id_object;
   delete from o_dt_ins_objects           where id_obj = :id_object;
 end
end
delete from d_dt_schedules                 where id_doc_info = :id_doc;
delete from d_dt_agents                    where id_doc = :id_doc;
delete from c_sp_proxy                     where id_contract = :id_doc;
delete from d_dt_imported_docs             where id_object = :id_doc and id_object_type = 119;
delete from d_dt_office_memo_states oms
 where exists(select null
  from d_dt_office_memos om
 where om.id_contract = :id_doc
   and om.id_office_memo = oms.id_office_memo);
delete from d_dt_office_memos om
 where id_contract = :id_doc
   and exists(select null
                from d_dt_insurance i
               where i.id_doc = :id_doc
                 and i.id_memorandum is null);
update b_dt_blanks
   set id_blank_state = 0,
       id_contract = null
 where id_contract = :id_doc;
delete from d_dt_ins_common_policies       where id_doc = :id_doc;
delete from d_dt_ins_policies              where id_doc = :id_doc;
delete from d_dt_insurance
 where id_doc = :id_doc;
delete from d_dt_office_memos om
 where id_contract = :id_doc
   and exists(select null
                from d_dt_insurance i
               where i.id_doc = :id_doc
                 and i.id_memorandum = om.id_office_memo);
delete from d_dt_document                  where id_doc = :id_doc;
delete from d_dt_contract_customers
 where id_contract_customer in (:id_contract_customer,
       :id_contract_native_customer,
       :id_contract_beneficiary);
exit;
end
--REG_NUM
if (:reg_num is null) then reg_num = :num_doc;
--NUM_DOC
if (:ext_num is not null)
then --если есть внешний номер - используем его
  begin
    num_doc_changed=1;
    num_doc=:ext_num;
  end
else --если внешнего номера нет - используем внутренний
  if (:reg_num is not null) then
  begin
    num_doc_changed=0;
    num_doc=:reg_num;
  end
if (:id_import_type = 21 or -- ОСАГО
:id_import_type = 23 or --НС МВД
:id_import_type = 24 or --ОТЛ МВД
:id_import_type = 25 or --ИМУЩЕСТВО (ПАСПОРТ) МВД
:id_import_type = 26 or --МЕД МВД
:id_import_type = 22 or --ВЗР МВД
:id_import_type = 27 or --НС КЛАССИКА
:id_import_type = 33 or --усб земля
:id_import_type = 34 --усб дом
    )
then --договора ВУСО
begin
 id_native_customer = 1;
-- ОСАГО полисы
 if (:id_import_type = 21) then
 begin
 policy_series = upper(:policy_series);
 policy_number = upper(:policy_number);

 sticker_series = upper(trim(:sticker_series));
 sticker_number = upper(trim(:sticker_number));

 if (:reg_num is null and (:policy_series is not null or :policy_number is not null)) then
   reg_num = coalesce(:policy_series, '') || ascii_char(160) || coalesce(:policy_number, '');
 end
-- договора МВД
 else
 if (:id_import_type = 23 or -- НС МВД
:id_import_type = 24 or -- ОТЛ МВД
:id_import_type = 25 or -- ИМУЩЕСТВО (ПАСПОРТ) МВД
:id_import_type = 26 or -- МЕД МВД
:id_import_type = 22    -- ВЗР МВД
   )
 then
 begin
 if (:id_department is not null) then
   select first 1 :reg_num || '-' || :ins_kind_code || '-' || dp.dep_code
     from c_sp_department dp
     join b_addr_places_koatuu pl on pl.id_place = dp.id_place
     left join b_addr_find_reg_distr_koatuu(1, pl.link_to) r on 1 = 1
    where dp.id_department = :id_department
     into :reg_num;
 else
 if (:department_code is not null) then
   select first 1 :reg_num || '-' || :ins_kind_code || '-' || dp.dep_code
     from c_sp_department dp
     join b_addr_places_koatuu pl on pl.id_place = dp.id_place
     left join b_addr_find_reg_distr_koatuu(1, pl.link_to) r on 1 = 1
    where r.region_code || dp.dep_code = :department_code
     into :reg_num;
-- <временно для генерации договров>
  if (:operation_kind like ('%' || :const_mvd || '%')) then
  begin
    num_doc_changed = 0;
    num_doc = :reg_num;
  end
 id_contract_native_signer = 11864;  -- Артюхов
 id_contract_native_signer_grd = 1;  -- Довіреність
 if (:id_contract_native_signer = 11864) then
   if (('01.01.2012' <= :date_doc) and (:date_doc < '02.01.2013'))
     then id_contract_native_signer_proxy = 4187;  -- ГК-А-2 2012
     else
       if (('02.01.2013' <= :date_doc) and (:date_doc < '01.01.2014'))
         then id_contract_native_signer_proxy = 9872;  -- ГК-А-2 2013
/* if (objects_package not in (20230)) then
id_memorandum = 40123; */
 end
 else
 -- НС классика
 if (:id_import_type = 27) then
 begin
   id_contract_native_signer = 9352;  -- Урсу Марьяна Андреевна
   id_contract_native_signer_grd = 1;  -- Довіреність
   --id_contract_native_signer_proxy = 2860;  -- ГС-Г-53 [2011-01-04]
   id_memorandum = 35238;
   objects_loading = 40;
 end
end
else
if (:id_import_type = 28 or  -- НС Еуропа
:id_import_type = 29 or  -- НС Еуропа-Життя
:id_import_type = 30 or  -- Кредиты Еуропа
:id_import_type = 31 or  -- Депозиты Еуропа
:id_import_type = 32     -- Еуропа компл им
    )
then -- договора Еуропа
begin
 if ((:policy_number is null) and (coalesce(:reg_num,'') <> '')) then
 select substring(:reg_num from
        position('-' in :reg_num) + 1 for
        position('.', :reg_num, position('-' in :reg_num)) - position('-' in :reg_num) - 1)
   from sys_options
   into :policy_number;
 department_code = '14' || :department_code;
 if ((agent_commissions_agent_1 = '400') or
     (agent_commissions_agent_1 = '401') or
     (agent_commissions_agent_1 = '402'))
 then
   sale_channel_name = 'Банк';
 else
   sale_channel_name = 'Агент-офіс';
 if (:id_import_type = 28 or -- Еуропа
     :id_import_type = 30 or
     :id_import_type = 31 or
     :id_import_type = 32)
 then
 begin
  id_native_customer = 1;
  id_officer = 31136;
  id_contract_native_signer = 31137;
  id_contract_native_signer_grd = 0;  --статут
--   id_contract_native_signer_proxy = 4433;
  if (:objects_contract_num is null) then
   objects_contract_num =
    iif(:id_import_type = 30, 'Кредит (', iif(:id_import_type = 31, 'Депозит (', null)) ||
    iif((coalesce(:reg_num,'') <> ''), :reg_num,iif((coalesce(:num_doc,'') <> ''), :num_doc,iif((coalesce(:ext_num,'') <> ''), :ext_num,''))) ||
    ')';
  if (:objects_contract_date is null) then objects_contract_date = :date_doc;
  if ((:id_import_type = 28) and
  ((agent_commissions_agent_1 = '400') or
   (agent_commissions_agent_2 = '400') or
   (agent_commissions_agent_3 = '400') or
   (agent_commissions_agent_4 = '400') or
   (agent_commissions_agent_5 = '400')))
 then
 begin
  inure_date_doc = dateadd(1 month to :date_doc) - EXTRACT(DAY FROM dateadd(1 month to :date_doc)) + 1;
  shedules_id_schelule_type = 0;
  id_doc_inure_type = 5;
 end
 end
 else
 if (:id_import_type = 29) then --Еуропа-Жизнь
 begin
  id_native_customer = 2;
  id_officer = 31142;
  id_contract_native_signer = 31462;
  id_contract_native_signer_grd = 0;  --статут
--   id_contract_native_signer_proxy = 4484;
  end
end
-- выбор доверенности по представителю СК
if ((:id_contract_native_signer_grd = 1) and
    (not (:id_contract_native_signer is null)) and
    (:id_contract_native_signer_proxy is null)) then
  select first 1
         sp.id_proxy
    from c_sp_proxy sp
   inner join c_sp_proxy_customers pc
      on sp.id_proxy=pc.id_proxy
   inner join c_dt_employees de
      on de.id_employee=pc.id_customer
   where :date_doc between sp.date_beg and sp.date_end
     and de.id_pk=:id_contract_native_signer
    into :id_contract_native_signer_proxy;
result = coalesce(:reg_num, :num_doc, '') || :end_string;
-- делаем перерасчёт плановых платежей ген. договора --
if (:recalc_general_contract_sum = 1) then
begin
 -- полисы
 if (:id_doc_type = 3) then
 begin
  delete
    from d_dt_schedules sc
   where sc.id_doc_info = :id_doc and sc.id_schedule_type = 0;--удаляем план
  -- формируем плановые платежи
  for
  select first 1 lp.id_lot_policy, lp.lot_policy_date
    from d_dt_ins_lot_policies lp
   where lp.id_multy_policy = :id_doc
    into :id_lot_policy, :shedules_schedule_date
  do
  begin
  select first 1 coalesce(sum(i.sum_doc), :general_contract_sum)
    from d_dt_ins_lot_policies lp, d_dt_ins_policies p, d_dt_insurance i
   where lp.id_lot_policy = p.id_lot_policy
     and p.id_doc = i.id_doc
     and lp.id_lot_policy = :id_lot_policy
    into :general_contract_sum;

  id_schedule = gen_id(get_d_schedule, 1);

 insert into d_dt_schedules (
        id_schedule, id_doc_info,
        schedule_date, schedule_sum,
        id_schedule_type)
 values (
        :id_schedule, :id_doc,
        :shedules_schedule_date, :general_contract_sum,
        0);
  end
  begin
  select first 1 sum(sc.schedule_sum)
    from d_dt_schedules sc
   where sc.id_doc_info = :id_doc and sc.id_schedule_type = 0
    into :general_contract_sum;

  update d_dt_insurance
     set sum_doc = :general_contract_sum
   where id_doc = :id_doc;

  update o_dt_insurance_params
     set obj_insurance_sum = :general_contract_sum
   where id_doc = :id_doc;
  end
 end
end
-- помечаем бланк как испорченный или чистый --
if (:policy_type in (-1, -2)) then
begin
  select first 1 id_blank, id_blank_state
    from b_dt_blanks
   where series = upper(:policy_series)
     and number = upper(:policy_number)
     and id_type = 1  -- Поліс
    into :id_blank, :id_blank_state;
  if (:id_blank is null) then
  begin
    result = iif(position(:ERR in :result) = 0, :ERR  || :end_string, '') || coalesce(:result, '') || :end_string || :ERROR_NOT_BLANK || :end_string;
    suspend;
  end
  else
  if (:id_blank_state <> 0) then  -- Чистый
  begin
    result = iif(position(:ERR in :result) = 0, :ERR  || :end_string, '') || coalesce(:result, '') || :end_string || :ERROR_BLANK_NOT_CLEAN || '[' || :id_blank_state || ']' || :end_string;
    suspend;
  end
  else
  if (:policy_series is not null and :policy_number is not null) then
  begin
  update b_dt_blanks b
     set b.id_blank_state = iif(:policy_type = -1, 3, 2),
         b.id_responsible = (select id_customer from a_user_sel_current),
         b.id_state_responsible = (select id_customer from a_user_sel_current),
         b.state_period = :date_doc
   where b.id_blank = :id_blank;  --Поліс
  end
  exit;
end
-- определяем заливает ли агент(web)
begin
     select first 1 spl.id_sale_point, dep.id_customer, a.agent_code, ad.id_agent_doc
       from a_user u
       join c_sp_customers cu
         on cu.id_customer = u.id_customer
       join c_dt_employees e
         on e.id_employee = cu.id_customer
        and current_date between coalesce(e.date_beg, '30.12.1899') and coalesce(e.date_end, '31.12.9999')
       join c_sp_department dep
         on dep.id_department = e.id_department
       join c_sp_sale_point_links spl
         on spl.id_sale_point = dep.id_department
  left join c_sp_agents a
         on a.id_customer = coalesce(dep.id_linked_legal, cu.id_customer)
  left join c_jn_agents_docs ad
         on ad.id_agent = a.id_agent
      where upper(u.login) = upper(current_user)
       into :id_sale_point, :id_sale_point_customer, :agent_code, :id_agent_contract;
  if (:id_sale_point is not null) then
  begin
  insurance_year = 1;
  sale_channel_name = iif(:id_sale_point_customer = 20571, 'Банк', 'Агент');
  officer_code = null;
  officer_name = null;
  depart_manager_code = null;
  depart_manager_name = null;
  agent_commissions_agent_2 = :agent_code;
  select first 1 coalesce(:id_officer, e.id_pk)
    from a_user u
    join c_sp_naturals n
      on upper(u.login) = upper(current_user)
     and u.id_customer = n.id_customer
    join c_dt_employees e
      on e.id_employee = n.id_customer
     and e.date_beg < current_date and (e.date_end is null or e.date_end > current_date)
   order by e.date_beg desc
    into :id_officer;
  select first 1 spl.id_department, coalesce (spl.id_department_head, spl.id_department_contact)
    from c_sp_sale_point_links spl
   where spl.id_sale_point = :id_sale_point
    into :id_department, :id_depart_manager;
    --здесь id_depart_manager - NATURAL
  select first 1 e.id_pk
    from c_sp_naturals n
    join c_dt_employees e
      on e.id_employee = n.id_customer
     and e.date_beg < current_date and (e.date_end is null or e.date_end > current_date)
   where :id_depart_manager = n.id_customer
order by e.date_beg desc
    into :id_depart_manager;
  end
end
-- поиск договора
if (:id_doc is not null) then
begin
  if (exists(select null
               from d_dt_document d
              where d.id_doc = :id_doc
                and d.id_doc_type <> :id_doc_type
                and d.id_state <> 5)) then
  begin
    result = iif(position(:ERR in result) = 0, :ERR  || end_string, '') || coalesce(result, '') || end_string || :ERROR_OTHER_CONTRACT_EXIST || end_string;
    suspend;
    exit;
  end
  select count(d.id_doc)
    from d_dt_document d
   where d.id_doc = :id_doc
     and d.id_doc_type = :id_doc_type
     and d.id_state <> 5
    into :contract_cnt;
end
else
if ((:reg_num is not null) or (:ext_num is not null)) then
begin
  if ((position(:const_mvd in :operation_kind) = 0) and
      (exists(select null
                from d_dt_document d
               where ((upper(d.reg_num) = upper(:reg_num)) or (upper(d.num_doc) = upper(:num_doc)))
                 and d.id_doc_type <> :id_doc_type
                 and d.id_state <> 5))) then
  begin
    result = iif(position(:ERR in result) = 0, :ERR  || end_string, '') || coalesce(result, '') || end_string || :ERROR_OTHER_CONTRACT_EXIST || end_string;
    suspend;
    exit;
  end
  else
  begin
    select count(d.id_doc)
      from d_dt_document d
     where ((upper(d.reg_num) = upper(:reg_num)) or (upper(d.num_doc) = upper(:num_doc)))
       and d.id_doc_type = :id_doc_type
       and d.id_state <> 5
      into :contract_cnt;
  end
end
else
  contract_cnt = 0;
if (:contract_cnt > 0) then
begin
  if (:contract_cnt > 1) then
  begin
    result = iif(position(:ERR in result) = 0, :ERR  || end_string, '') || coalesce(result, '') || end_string || :ERROR_CONTRACT_EXIST || end_string;
    suspend;
    exit;
  end
  else
  begin
    select first 1 d.id_doc, d.id_state
      from d_dt_document d
     where ((upper(d.reg_num) = upper(:reg_num)) or (upper(d.num_doc) = upper(:num_doc)))
       and d.id_doc_type = :id_doc_type
       and d.id_state <> 5
      into :id_doc, :id_state;
    if (:recreated = 1 and :id_state = 1) then
    begin
      contract_cnt = 0;
      result = coalesce(:result, '') || :id_doc || :end_string || :WARNING_CONTRACT_EXIST || end_string;
    end
    else
    begin
      result = iif(position(:ERR in result) = 0, :ERR  || end_string, '') || coalesce(result, '') || end_string || :ERROR_CONTRACT_EXIST || end_string;
      suspend;
      exit;
    end
  end
end
else
begin
  recreated = 0;
  id_doc = gen_id(get_d_document, 1);
  result = coalesce(:result, '') || :id_doc || :end_string;
end
-- поиск и создание страхователя
if (:recreated = 1) then
begin
  select first 1 cc.id_customer
    from d_dt_document d, d_dt_contract_customers cc
   where d.id_contract_customer = cc.id_contract_customer
     and cc.contract_customer_type = 0  -- страхователь
     and d.id_doc = :id_doc
    into :id_customer;
end
if (:id_customer is null) then
begin
-- проверяем тип страхователя (физ/юр лицо)
if (:id_customer_type is null) then
begin
result = iif(position(:ERR in result) = 0, :ERR || end_string, '') || coalesce(result, '') || :ERROR_NOT_CUSTOMER_TYPE || end_string;
if (:validated = 1) then
begin
  suspend;
  exit;
end
end
-- попытаемся взять страхователя из владельца объекта (авто) страхования
if (:objects_auto_body_number is not null) then
begin
select cs.id_customer
  from o_dt_ins_objects o, o_dt_ins_autos a, c_sp_customers cs
 where o.id_obj = a.id_obj
   and o.id_owner = cs.id_customer
   and cs.id_customer_type = :id_customer_type
   and upper(cs.search_name) = upper(:customer_name)
   and upper(a.body_num) = upper(:objects_auto_body_number)
  into :id_customer;
end
custumer_memo =
coalesce(:custumer_memo, '') ||
coalesce('Контактная информация: ' || :customer_cust_memo_1 || end_string, '') ||
coalesce('Должность / профессия: ' || :customer_cust_memo_2 || end_string, '') ||
coalesce('Тип: '                   || :customer_cust_memo_3 || end_string, '') ||
coalesce('Вид: '                   || :customer_cust_memo_4 || end_string, '') ||
coalesce('Категория: '             || :customer_cust_memo_5 || end_string, '') ||
coalesce('Примечание: '            || :customer_cust_memo_6 || end_string, '');
select first 1 cs.result_id_customer
from i_up_add_customers(
:operation_kind, 1, :allow_search, :id_customer, :id_customer_1c, :id_customer_type,
:customer_code, :customer_name, :customer_driver_exper_year, :custumer_memo,
:customer_birth_date,:customer_address, :customer_address_country_id, :customer_id_place,
:customer_place_name, :customer_place_type,:customer_region_code, :customer_region_name,
:customer_address_street, :customer_address_house, :customer_address_flat, :customer_post,
:customer_phone, :customer_series_driver_doc, :customer_number_driver_doc,
:id_privilege, :customer_series_privilage_doc, :customer_number_privilage_doc,
:customer_series_int_pass, :customer_number_int_pass, :customer_series_ukr_pass,
:customer_number_ukr_pass, :customer_series_for_pass, :customer_number_for_pass,
:end_string, :date_doc) cs
into :id_customer; 
if (:id_customer is null and :customer_name is null) then
begin
result = iif(position(:ERR in result) = 0, :ERR  || end_string, '') || coalesce(result, '') || :ERROR_NOT_CUSTOMER_NAME || end_string;
if (:validated = 1) then
begin
  suspend;
  exit;
end
end
end
-- поиск выгодоприобретателя
if (:recreated = 1) then
begin
  select first 1 cc.id_customer
    from d_dt_insurance d, d_dt_contract_customers cc
   where d.id_contract_beneficiary = cc.id_contract_customer
     and cc.contract_customer_type = 2  -- выгодоприобретатель
     and d.id_doc = :id_doc
    into :id_beneficiary;
end
if (:id_beneficiary is null and (:beneficiary_code is not null or :beneficiary_name is not null)) then
begin
select first 1 cs.result_id_customer
  from i_up_add_customers(
    :operation_kind, 1, :allow_search, :id_beneficiary, null, :id_beneficiary_type,
    :beneficiary_code, :beneficiary_name, null, null, null, null, null,
    :beneficiary_id_place, :beneficiary_place_name, :customer_place_type,
    null, null,:beneficiary_address_street, :beneficiary_address_house,
    :beneficiary_address_flat,:beneficiary_post,null,null,null,null, null, null,null,
    null,null, null,null, null,:end_string, :date_doc) cs
  into :id_beneficiary;
if (:id_beneficiary is null) then
  result = coalesce(result, '') || :WARNING_NOT_FIND_BENEFICIARY || end_string;
end
--создаём связки "контрагенты - договор"
-- создаём связку договор - страхователь
contract_customer_type = 0;  -- страхователь
if (:recreated = 1) then
begin
  select first 1 d.id_contract_customer
    from d_dt_document d, d_dt_contract_customers cc
   where d.id_contract_customer = cc.id_contract_customer
     and cc.contract_customer_type = 0  -- страхователь
     and d.id_doc = :id_doc
    into :id_contract_customer;
end
else
  id_contract_customer = gen_id(gen_d_dt_contract_customers_id, 1);

  select first 1 cc.id_contract_customer
    from d_up_dt_contract_customers(
      iif(:recreated = 1, 2, 1), :id_contract_customer, null,
      :contract_customer_type, :id_customer, null, null,
      null, null, null, null, null, null, null, null, null, null, null,
      null, null, null, null, null, null, null) cc
    into :id_contract_customer;
-- создаём связку договор - страховщик
contract_native_customer_type = 1;  -- страховщик
if (:recreated = 1) then
begin
select first 1 d.id_contract_customer_native
  from d_dt_document d, d_dt_contract_customers cc
 where d.id_contract_customer_native = cc.id_contract_customer
   and cc.contract_customer_type = 1  -- страховщик
   and d.id_doc = :id_doc
  into :id_contract_native_customer;
end
else
  id_contract_native_customer = gen_id(gen_d_dt_contract_customers_id, 1);

  select first 1 cc.id_contract_customer
    from d_up_dt_contract_customers(
      iif(:recreated = 1, 2, 1), :id_contract_native_customer, null,
      :contract_native_customer_type, :id_native_customer, :id_native_account, null,
      :id_contract_native_signer, :id_contract_native_signer_grd, :id_contract_native_signer_proxy,
      null, null, null, null, null, null, null, null,
      null, null, null, null, null, null, null) cc
    into :id_contract_native_customer;
-- создаём связку договор - выгодоприобетатель
contract_beneficiary_type = 2;  -- выгодоприобетатель
if (:recreated = 1) then
begin
select first 1 d.id_contract_beneficiary
  from d_dt_insurance d, d_dt_contract_customers cc
 where d.id_contract_beneficiary = cc.id_contract_customer
   and cc.contract_customer_type = 2  -- выгодоприобетатель
   and d.id_doc = :id_doc
  into :id_contract_beneficiary;
end
else
 id_contract_beneficiary = gen_id(gen_d_dt_contract_customers_id, 1);

 select first 1 cc.id_contract_customer
   from d_up_dt_contract_customers(iif(:recreated = 1, 2, 1), :id_contract_beneficiary, null,
:contract_beneficiary_type, :id_beneficiary, :id_beneficiary_account, null,
null, null, null, null, null, null, null, null, null, null, null,
null, null, null, null, null, null, null) cc
   into :id_contract_beneficiary;
--создаём договор страхования (черновик)
-- определяем подразделение
if (:id_department is null) then
begin
 select first 1 dp.id_department
   from c_sp_department dp
   join b_addr_places_koatuu pl on pl.id_place = dp.id_place
   left join b_addr_find_reg_distr_koatuu(1, pl.link_to) r on 1 = 1
  where r.region_code || dp.dep_code = :department_code
   into :id_department;
 if (:id_department is null) then
 begin
   result = iif(position(:ERR in result) = 0, :ERR  || end_string, '') || coalesce(result, '') || :ERROR_NOT_FIND_DEPARTMENT || end_string;
   suspend;
   exit;
 end
end
-- определяем ответственного исполнителя
if (:allow_search = 1) then
begin
 if (:id_officer is null) then
 begin
   select first 1 ofc.id_customer
     from c_up_find_employee_1c(:id_officer, :officer_code, :officer_name, :id_department, :date_doc) ofc
     into :id_officer;
 end
 if (:id_officer is null) then
 begin
   result = iif(position(:ERR in result) = 0, :ERR  || end_string, '') || coalesce(result, '') || :ERROR_NOT_FIND_OFFICER || end_string;
   if (:validated = 1) then
   begin
     suspend;
     exit;
   end
 end
end
-- определяем финансового консультанта
if (:allow_search = 1) then
begin
  if (:id_financ_consultant is null) then
  begin
    select first 1 fc.id_customer
      from c_up_find_employee_1c(:id_financ_consultant, :financ_consultant_code, :financ_consultant_name, :id_department, :date_doc) fc
      into :id_financ_consultant;
  end
  if (:id_financ_consultant is null and
      (:financ_consultant_code is not null or :financ_consultant_name is not null))
  then
    result = coalesce(result, '') || :WARNING_NOT_FIND_FINANC_CONSULTANT || end_string;
end
-- определяем руководителя подразделения
if (:allow_search = 1) then
begin
  if (:id_depart_manager is null) then
  begin
    select first 1 dm.id_customer
      from c_up_find_employee_1c(:id_depart_manager, :depart_manager_code, :depart_manager_name, :id_department, :date_doc) dm
      into :id_depart_manager;
  end
  if (:id_depart_manager is null and
      (:depart_manager_code is not null or :depart_manager_name is not null))
  then
    result = coalesce(result, '') || :WARNING_NOT_FIND_DEPART_MANAGER || end_string;
end
-- определяем ответственного за скидку
if (:allow_search = 1) then
begin
  if (coalesce(:discount,0) <> 0) then
  begin
    if (:id_respons_disc is null) then
    begin
      select first 1 rd.id_customer
        from c_up_find_employee_1c(:id_respons_disc, :respons_disc_code, :respons_disc_name, :id_department, :date_doc) rd
        into :id_respons_disc;
    end
    if (:id_respons_disc is null and
        (:respons_disc_code is not null or :respons_disc_name is not null))
    then
      result = coalesce(result, '') || :WARNING_NOT_FIND_RESPONS_DISC || end_string;
  end
end
-- определяем тип вступления
if (:id_doc_inure_type is null) then
begin
  select first 1 it.id_doc_inure_type
    from d_ini_inure_types it
   where upper(it.name_doc_inure_type) = upper(:doc_inure_type_name)
    into :id_doc_inure_type;
  if (:id_doc_inure_type is null) then
  begin
    result = iif(position(:ERR in result) = 0, :ERR  || end_string, '') || coalesce(result, '') || :ERROR_NOT_FIND_INURE_TYPE || end_string;
    if (:validated = 1) then
    begin
      suspend;
      exit;
    end
  end
end
-- определяем вид страхования
begin
  select first 1 ik.id_ins_kind
    from b_sp_ins_kind ik
   where ik.code_ins_kind = :ins_kind_code
    into :id_ins_kind;
  if (:id_ins_kind is null) then
  begin
    select first 1 ik.id_ins_kind
      from b_sp_ins_kind ik
     where upper(ik.name_ins_kind) = upper(:ins_kind_name)
      into :id_ins_kind;
  end
  if (:id_ins_kind is null) then
  begin
    result = iif(position(:ERR in result) = 0, :ERR  || end_string, '') || coalesce(result, '') || :ERROR_NOT_FIND_INS_KIND || end_string;
    if (:validated = 1) then
    begin
      suspend;
      exit;
    end
  end
end
-- определяем канал продаж
begin
   select first 1 sc.id_sale_channel
     from d_sp_insurance_programs sc
    where upper(sc.sale_channel_name) = upper(:sale_channel_name)
     into :id_sale_channel;
             
  if (:id_sale_channel is null) then
  begin
    result = iif(position(:ERR in result) = 0, :ERR  || end_string, '') || coalesce(result, '') || :ERROR_NOT_FIND_SALE_CHANNEL || end_string;

    if (:validated = 1) then
    begin
      suspend;
      exit;
    end
  end
end
-- определяем агентское соглашение
if (:id_agent_contract is null) then
begin
  if (:agent_contract_name is not null) then
  begin
  select first 1 d.id_doc
    from d_dt_document d
   where d.id_doc_type = 1  -- агентское соглашение
     and upper(d.reg_num) = upper(:agent_contract_name)
    into :id_agent_contract;

  if (:id_agent_contract is null) then
    result = coalesce(result, '') || :WARNING_NOT_FIND_AGENT_CONTRACT || end_string;
  end
end
-- создаём договор страхования
begin
  id_doc_sub_type = coalesce(:id_doc_sub_type, 0);
  id_status = coalesce(:id_status, 1);  -- не вступил в силу
  id_state = coalesce(:id_state, 1);  -- черновик
  bonus = coalesce(:bonus, 1);
  insurance_year = coalesce(:insurance_year, 1);
  if (:shedules_id_schelule_type is null) then
    shedules_id_schelule_type = 2;  -- 1 месяц
  -- определяем текущего пользователя
  select first 1 u.id_customer
    from a_user u, a_user_sel_current cu
   where u.id_user = cu.id_user
    into :id_contract_creator;
  -- определяем дату закрытия периода
  select closed_period
    from sys_options
    into :closed_period;
  -- <временно для генерации договров>
  if ((:allow_search = 0) and (:operation_kind like ('%' || :const_mvd || '%'))) then
  begin
    id_state = 3;
    closed_period = cast('31.03.2012' as tdate);
  end
  -- </временно для генерации договров>
  if (:date_doc <= :closed_period) then
  begin
  is_other_innure = 1;
  other_date_doc = :closed_period + 1;
  if (:inure_date_doc <= :closed_period) then
    other_inure_date_doc = :closed_period + 1;
  else
    other_inure_date_doc = :inure_date_doc;

  if (:end_date_doc <= :closed_period) then
    other_end_date_doc = :closed_period + 1;
  else
    other_end_date_doc = :end_date_doc;
  end
  else
  begin
    is_other_innure = null;
    other_date_doc = null;
    other_inure_date_doc = null;
    other_end_date_doc = null;
  end
id_contract_signer = :id_contract_creator;
id_contract_acceptor = :id_contract_creator;
id_contract_stater = :id_contract_creator;
state_change_date = current_timestamp;
id_respons_disc = coalesce(:id_respons_disc, iif(coalesce(:discount, 0) = 0, null, :id_depart_manager));
insurance_amount = null;
valid_cost = null;
insurance_payment = null;
if (:allow_search = 0) then
  contract_memo = coalesce(:memo || :end_string, '') ||
    iif(:id_sale_channel is null, coalesce('Канал продаж: ' || :sale_channel_name, ''), '');
else
  contract_memo = iif(:id_sale_point is null, 'Импорт локально', 'Импорт WEB') || :end_string ||
    coalesce('Примечание: ' || :memo || :end_string, '') ||
    iif(:id_sale_channel is null, coalesce('Канал продаж: ' || :sale_channel_name, ''), '');
-- поиск бланка
  begin
    select id_blank
      from d_dt_document
     where id_doc = :id_doc
      into :id_blank;

    if (:id_blank is null) then
    begin
      if (:id_doc_type = 3) then
      begin
        select id_blank
          from b_dt_blanks b
         where b.id_type = 1
           and b.number = :policy_number
           and b.series = :policy_series
          into :id_blank;
      end
      else
      begin
        select id_blank
        from b_dt_blanks b
        where b.id_type = 3
          and (b.blank_string || '-' = case
                 when b.number < 1000000
                   then coalesce(substring(:policy_number from 1 for 7), substring(:num_doc from 1 for 7), substring(:reg_num from 1 for 7), '-') 
                 else   coalesce(substring(:policy_number from 1 for 8), substring(:num_doc from 1 for 8), substring(:reg_num from 1 for 8), '-')
              end
            or b.blank_string = coalesce(:policy_number, :num_doc, :reg_num, '')
          )
        into :id_blank;

        if((:id_blank is null) and
           (:policy_number is null) and
           (:id_import_type = 28 or
:id_import_type = 29 or
:id_import_type = 30 or
:id_import_type = 31 or
:id_import_type = 32 or
:id_import_type = 33 or
:id_import_type = 34 or
:id_import_type = 35
            ))then -- Еуропа
        begin
          select first 1 a.id_agent
            from c_sp_agents a
           where a.agent_code = coalesce(
:agent_commissions_agent_2,
:agent_commissions_agent_1,
:agent_commissions_agent_3,
:agent_commissions_agent_4,
:agent_commissions_agent_5)
            into :id_agent;

          id_dep_list= '';

          for
            select dsc.id_dep_out
              from c_sp_department_sel_id_childs(:id_department, :date_doc, :date_doc, 1) dsc
              into :id_dep
          do
          begin
            if(:id_dep_list<>'')then
              id_dep_list=:id_dep_list || ',';
            id_dep_list=:id_dep_list || :id_dep;
          end

          select first(1) b.blank_id
            from b_up_dt_blanks(0, null, 3, null, null, null, 0, null, 0,
                                null, null, null, null, null, null, null, null, :id_agent, null, null, null, null, null, null, null, :date_doc, null, null, :id_dep_list, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null) b
            into :id_blank;
           id_agent=null;
        end
        if(:id_blank is null)then
        begin
            result = iif(position(:ERR in :result) = 0, :ERR  || :end_string, '') || coalesce(:result, '') || :end_string || :ERROR_NOT_BLANK || :end_string;
            suspend;
            exit;
        end
      end
    end
  end

  /* Для id_registration_dep установил заглушку*/
  select first 1 i.id_doc
    from d_up_dt_insurance(
iif(:recreated = 1, 2, 1), :id_doc, null, :num_doc_changed, :reg_num, iif(:id_doc_type <> 3, :num_doc, :policy_number),
null, :date_doc, :other_date_doc, null, null, null, null, :id_contract_native_customer,
:id_contract_customer, :id_doc_type, null, :id_doc_sub_type, null, null, :arch_num_doc,
null, null, null, null, :contract_memo, :id_blank, null, :id_state, :id_status,
:id_contract_creator, :id_contract_signer, :id_contract_acceptor, :id_contract_stater,
:state_change_date, :id_doc_inure_type,
:is_other_innure, :inure_date_doc,:other_inure_date_doc, null, null,
:end_date_doc,:other_end_date_doc, null, null,:end_date_doc - :inure_date_doc + 1,
:id_officer,:id_department, null, null,null, null,null,
:id_doc_source, null, null, null, null, null, null, null, null, 
:id_ins_kind,:id_contract_beneficiary,
:id_memorandum,null, null, null,:insurance_payment,:id_ins_currency,null,:valid_cost,
:id_ins_currency,:insurance_amount,:id_ins_currency,null, null, null,:discount,:id_respons_disc,
:bonus,null,null,:id_sale_channel, :id_agent_contract, :id_depart_manager,
:id_financ_consultant, :insurance_year, null, :shedules_id_schelule_type, null,
null, null, :id_sale_point, null, null, null, null, null, null, null, null, null, null, null, null, null,
null, null, null, null, null, null) i
  into :id_doc;
  -- добавляем расширение договора по его типу
  execute procedure i_up_add_contracts(
:operation_id,operation_kind,:allow_search,:validated,:recreated,:id_import_type,:id_doc,:id_doc_type,
:date_doc,:inure_date_doc, :end_date_doc,
:bonus, :own_insurance_payment, :real_insurance_payment, :real_insurance_tariff,:real_insurance_sum,:policy_type,
:id_beneficiary, :beneficiary_name,:id_officer, :officer_code, :officer_name,
:id_financ_consultant, :financ_consultant_code, :financ_consultant_name,
:id_depart_manager, :depart_manager_code, :depart_manager_name,:id_contract_native_signer,
:id_department,:department_code,:department_name,:ins_kind_code, :ins_kind_name,
:sale_channel_name, :doc_inure_type_name,:id_memorandum,:id_customer,
:life_limit, :property_limit, :franchise,
:objects_id_tariff, :objects_package,
:objects_insurance_tariff_calc, :objects_insurance_tariff, null,
:id_privilege,:general_contract_number, :general_contract_date,
:objects_auto_reg_type_id, :objects_auto_reg_date,:special_conditions_id,
:territory_of_action_id,:destination_country_id, :period_abroad_total,
:period_abroad_per_one, :id_doc_source,:is_multivisa,:loyal_customers,:id_ins_currency,:is_family_or_group,:group_count);
end

  --поиск стикера
  if (:id_doc_type = 3) then
  begin
    id_sticker = null;
    select b.id_blank
    from b_dt_blanks b
    where b.series = :sticker_series and
          b.number = :sticker_number and
          b.id_type = 2 --sticker type
    into :id_sticker;

    if ((id_sticker is not null) and
        not exists (select 1
                    from b_dt_blanks b
                    where b.id_blank = :id_sticker and
                          b.id_contract = :id_doc)) then
      update b_dt_blanks b
      set b.id_contract=:id_doc
      where b.id_blank=:id_sticker;
  end

--определяем город регистрации
if (:registration_id_place is null) then
begin
   select count(pl.id_place)
     from b_addr_places_koatuu pl
     left join b_addr_find_reg_distr_koatuu(1, pl.link_to) r on 1 = 1
    where  upper(pl.place_name)= upper(:registration_place_name)
      and (upper(r.region_code)= upper(:registration_region_code) or
           upper(r.name_out)   = upper(:registration_region_name))
     into :cnt;

  if (:cnt = 1) then
  begin
   select first 1 pl.id_place
     from b_addr_places_koatuu pl
     left join b_addr_find_reg_distr_koatuu(1, pl.link_to) r on 1 = 1
    where upper(pl.place_name) = upper(:registration_place_name)
      and (upper(r.region_code)= upper(:registration_region_code) or
           upper(r.name_out)   = upper(:registration_region_name))
     into :registration_id_place;
  end
  else
  -- если не нашли город регистрации, то добавляем его в примечание
  begin
   update d_dt_document
      set memo = coalesce(memo, '') || :end_string || coalesce('Место регистрации: ' || :registration_place_name, '')
    where id_doc = :id_doc;
  end
end
--поиск и создание личности
if (:id_insured is null and not :insured_name is null) then
begin
  -- проверяем тип личности (физ/юр лицо)
  if (:id_insured_type is null) then
  begin
    result = iif(position(:ERR in result) = 0, :ERR || end_string, '') || coalesce(result, '') || :ERROR_NOT_PERSON_TYPE || end_string;

    if (:validated = 1) then
    begin
      suspend;
      exit;
    end
  end
  -- попытаемся взять страхователя из владельца объекта (авто) страхования
  if (:objects_auto_body_number is not null) then
  begin
  select cs.id_customer
    from o_dt_ins_objects o, o_dt_ins_autos a, c_sp_customers cs
   where o.id_obj = a.id_obj
     and o.id_owner = cs.id_customer
     and cs.id_customer_type = :id_insured_type
     and upper(cs.search_name) = upper(:insured_name)
     and upper(a.body_num) = upper(:objects_auto_body_number)
    into :id_customer;
  end

  select first 1 cs.result_id_customer
  from i_up_add_customers(
   :operation_kind, 1, :allow_search, :id_insured, null, :id_insured_type,
   :insured_code, :insured_name, :insured_driver_exper_year, null, :insured_birth_date,
   :insured_address, :insured_address_country_id,:insured_id_place, :insured_place_name,
   :insured_place_type,:insured_region_code, :insured_region_name, :insured_address_street,
   :insured_address_house, :insured_address_flat, :insured_post, :insured_phone,
   :insured_series_driver_doc, :insured_number_driver_doc,
   :id_privilege, :insured_series_privilage_doc, :insured_number_privilage_doc,
   :insured_series_int_pass, :insured_number_int_pass, :insured_series_ukr_pass,
   :insured_number_ukr_pass, :insured_series_for_pass, :insured_number_for_pass,
   :end_string, :date_doc) cs
  into :id_insured;

  if (:id_insured is null and :insured_name is null) then
  begin
    result = iif(position(:ERR in result) = 0, :ERR  || end_string, '') || coalesce(result, '') || :ERROR_NOT_INSURED_NAME || end_string;

    if (:validated = 1) then
    begin
      suspend;
      exit;
    end
  end
end
else
if (:id_insured is null and :insured_name is null) then
begin
  id_insured = :id_customer;
end
--создаём объект страхования
if ((:recreated = 1) and (exists(select null
                                   from o_dt_insurance_params ip
                                  where ip.id_doc = :id_doc)))
then
select ip.id_obj
 from d_dt_document d, o_dt_insurance_params ip
where d.id_doc = ip.id_doc
  and d.id_doc = :id_doc
 into :id_object;

if (:id_doc_type in (6,16,22,38,39))then --НС,МЕД,ОТЛ,ВЗР,Жизнь
 if (:objects_auto_model is null) then objects_auto_model = coalesce(:insured_name, :customer_name);

select first 1 obj.result_id_object
from i_up_add_objects(
:operation_kind, :id_import_type, :allow_search, :id_doc_type, iif(:id_doc_type <> 3, :num_doc, :policy_number),
:policy_type, :id_object, :id_customer,
:id_insured,:objects_auto_model, :objects_auto_number, :objects_auto_body_number,
:objects_auto_manufact_year, :objects_auto_manufact_month, :objects_auto_manufact_month_cor,
:objects_auto_engine_volume, :objects_auto_category_code, :date_doc, :registration_id_place,
:objects_contract_num, :objects_contract_date) obj
into :id_object;
-- создаём параметры страхования --
if ((:recreated = 1) and
(exists(select null
 from o_dt_insurance_params ip
 where ip.id_doc = :id_doc)))
then
begin
select ip.id_insurance
 from d_dt_document d, o_dt_insurance_params ip
where d.id_doc = ip.id_doc
 and d.id_doc = :id_doc
into :id_insurance;
end
else
  id_insurance = gen_id(gen_o_dt_insurance_params_id, 1);

if (:id_insurance is not null) then
begin
  -- определяем порядковый номер объекта страхования
select count(ip.id_insurance)
from o_dt_insurance_params ip
where ip.id_doc = :id_doc
into :object_number;

object_number = coalesce(:object_number, 0) + 1;

begin
objects_count = 1;
if (:id_memorandum is not null)
then is_changed_package = 1;
else is_changed_package = 0;

if (:id_doc_type = 38) then
begin
if (:med_ins_sum  is null) then med_ins_sum  = :objects_insurance_sum;
if (:med_ins_paym is null) then med_ins_paym = :objects_insurance_payment;
if (:med_ins_tariff is null
and :med_ins_paym is not null
and :period_abroad_total is not null) then
 med_ins_tariff = round(:med_ins_paym / :period_abroad_total,2);
if (:accid_ins_tariff is null
and :accid_ins_paym is not null
and :period_abroad_total is not null) then
 accid_ins_tariff = round(:accid_ins_paym / :period_abroad_total,2);
if (:bagage_ins_tariff is null
and :bagage_ins_paym is not null
and :period_abroad_total is not null) then
 bagage_ins_tariff = round(:bagage_ins_paym / :period_abroad_total,2);
end

 objects_insurance_sum         = cast(coalesce(:objects_insurance_sum,     :real_insurance_sum) as numeric(18,10));
 objects_insurance_tariff      = cast(coalesce(:objects_insurance_tariff,  :real_insurance_tariff) as numeric(18,10));
 objects_insurance_payment     = cast(coalesce(:objects_insurance_payment, :real_insurance_payment) as numeric(18,10));
 objects_insurance_tariff_calc = cast(coalesce(:objects_insurance_tariff_calc, :objects_insurance_tariff) as numeric(18,10));

 if (:objects_insurance_sum is null and
     :objects_insurance_payment is not null and
     :objects_insurance_tariff_calc is not null)
 then
   objects_insurance_sum = (cast(:objects_insurance_payment as numeric(18,5)) * 100) / (cast(:objects_insurance_tariff_calc as numeric(18,5)));
 -- Для полисов обнуляем страховую сумму
 if (:id_doc_type = 3) then
  objects_insurance_sum = null;

 objects_k_fake = coalesce(:objects_k_fake, 1);
 objects_k0 = coalesce(:objects_k0, 1);
 objects_insurance_payment_calc = null;
 if(own_insurance_payment is null)then
 begin
  original_ins_tariff=:real_insurance_tariff;
  original_ins_payment=:real_insurance_payment;
 end

select first 1 ip.id_insurance
from o_up_dt_insurance_params(
 iif(:recreated = 1, 2, 1), :id_insurance, null, :id_doc, null,
 :id_object, :objects_count, null, :objects_package, :is_changed_package,
 :object_number, null,  null, :objects_insurance_sum, :id_ins_currency,
 :objects_insurance_sum, :id_ins_currency, null, null, null, :franchise,
 null, :objects_insurance_tariff, :original_ins_tariff, :objects_insurance_tariff_calc,
 null, :original_ins_payment, :objects_insurance_payment_calc, :objects_insurance_payment,
 null, null, null, null, null, null, null, null, null, null, null, null, null,
 :objects_loading,:objects_k_fake,:objects_k0, null, null, null, null, null, null, null, null) ip
into :id_insurance;
    -- добавляем параметры страхования
execute procedure i_up_add_insurance_params(
:operation_kind, :recreated, :allow_search,:id_import_type,:end_string,:id_insurance, :id_doc_type, :date_doc,
:customer_registrtion_code, :registration_id_place,
:enabled_category_a, :enabled_category_b, :enabled_category_c,
:enabled_category_d, :enabled_category_e, :enabled_category_f,
:policy_type,:life_limit, :property_limit,:objects_package,
:objects_k1, :objects_k2, :objects_k3,:objects_k4, :objects_k5, :objects_k6, :objects_k7, :objects_k8,
:driver_name_1, :series_driver_doc_1, :number_driver_doc_1, :driver_exper_year_1,
:driver_name_2, :series_driver_doc_2, :number_driver_doc_2, :driver_exper_year_2,
:driver_name_3, :series_driver_doc_3, :number_driver_doc_3, :driver_exper_year_3,
:driver_name_4, :series_driver_doc_4, :number_driver_doc_4, :driver_exper_year_4,
:objects_auto_unuse_mounth, :objects_auto_taxi, :objects_auto_3exp,
:id_insured_program,:name_insured_program,
:objects_insurance_sum, :objects_insurance_payment,:id_ins_currency,
:id_med_ins_currency,:med_ins_sum,:med_ins_tariff,:med_ins_paym,
:id_accid_ins_currency,:accid_ins_sum,:accid_ins_tariff,:accid_ins_paym,
:id_bagage_ins_currency,:bagage_ins_sum,:bagage_ins_tariff,:bagage_ins_paym,
:age,:special_conditions_id,:territory_of_action_id,:destination_country_id,
:period_abroad_total,:period_abroad_per_one,:is_multivisa,:loyal_customers,
:is_family_or_group, :objects_insurance_sum, :objects_insurance_tariff_calc,
:objects_insurance_payment );
end
end
-- сохраняем в договор агрегированные суммы по объектам --
begin
 select sum(ip.obj_insurance_sum), sum(ip.obj_valid_cost), sum(ip.insurance_payment)
 from o_dt_insurance_params ip
 where ip.id_doc = :id_doc
 into :insurance_amount, :valid_cost, :insurance_payment;

 update d_dt_insurance i
 set i.insurance_sum = :insurance_amount,
 i.valid_cost = :valid_cost,
 i.sum_doc = :insurance_payment
 where i.id_doc = :id_doc;
end
-- добавляем плановый платёж к договору страхования --
if (:insurance_payment is not null) then
begin
execute procedure i_up_add_schedules(
:recreated, :id_import_type, :id_doc, :date_doc,
:inure_date_doc, :end_date_doc, :insurance_payment,
:agent_commissions_agent_1, :agent_commissions_agent_2,
:agent_commissions_agent_3, :agent_commissions_agent_4,
:agent_commissions_agent_4);
end
-- добавляем агентов к договору страхования --
if ((:recreated = 1)
and (exists(select null
 from d_dt_agents a
 where a.id_doc = :id_doc))) then
begin
delete
from d_dt_agents a
where a.id_doc = :id_doc;
end

begin
 i = 1;
 while (i <= 5) do
 begin
if (i = 1) then agent_code = :agent_commissions_agent_1; else
if (i = 2) then agent_code = :agent_commissions_agent_2; else
if (i = 3) then agent_code = :agent_commissions_agent_3; else
if (i = 4) then agent_code = :agent_commissions_agent_4; else
if (i = 5) then agent_code = :agent_commissions_agent_5;

if (:agent_code is not null) then
begin
 select first 1 a.id_agent
   from c_sp_agents a
  where a.agent_code = :agent_code
   into :id_agent;

 select count(da.id_doc)
   from d_dt_agents da
  where da.id_doc = :id_doc
    and da.id_agent = :id_agent
   into :cnt;

if (:cnt = 0) then
begin
    id_doc_agent = gen_id(gen_d_dt_agents_id, 1);
-- определяем комиссию и тип комисии по агенту и сохраняем в договор
select first 1 ac.commission, ac.id_type_commission
 from c_dt_agents_comm ac
where ac.id_agent = :id_agent
  and ac.id_ins_kind = :id_ins_kind
 into :agent_comission, :agent_comission_type;

select first 1 da.id_doc_agent
from d_up_dt_agents(1, :id_doc_agent, :id_doc, :id_agent,
                   :agent_comission, :agent_comission_type, null,null,null) da
into :id_doc_agent;

id_agent_doc=null;
select first(1) ad.id_agent_doc
from c_jn_agents_docs ad
inner join d_dt_document dd
on ad.id_agent_doc=dd.id_doc
where (:date_doc between dd.date_doc and dd.end_date_doc
or dd.date_doc between :date_doc and :end_date_doc)
and ad.id_agent=:id_agent
order by ad.id_agent_doc desc
into :id_agent_doc;

if(id_agent_doc is not null)then
begin
id_doc_agent = gen_id(gen_d_dt_agents_id, 1);
select first 1 da.id_doc_agent
from d_up_dt_agents(1, :id_doc_agent, :id_doc, null,
                    null, 2, :id_agent_doc, null,null) da
into :id_doc_agent;
end
end
 end
   i = i + 1;
 end
end
select rdb$set_context('USER_SESSION', 'EXPORT_IGNORE', null) from sys_options into :k;

if (position(:ERR in result) = 0) then
  result = :OK || end_string || coalesce(result, '');

  suspend;
end^

SET TERM ; ^

COMMENT ON PROCEDURE I_UP_ADD_CUSTOM IS
'Старый импорт. Процедура импорта договоров (базовая процедура)';

/* Следующие операторы GRANT сгенерированы автоматически */

GRANT SELECT ON P_SP_TARIFF_MEMBERS TO PROCEDURE I_UP_ADD_CUSTOM;
GRANT SELECT ON SYS_OPTIONS TO PROCEDURE I_UP_ADD_CUSTOM;
GRANT SELECT,DELETE,UPDATE ON D_DT_DOCUMENT TO PROCEDURE I_UP_ADD_CUSTOM;
GRANT SELECT,DELETE,UPDATE ON O_DT_INSURANCE_PARAMS TO PROCEDURE I_UP_ADD_CUSTOM;
GRANT SELECT,DELETE ON D_DT_RE_OBJECTS TO PROCEDURE I_UP_ADD_CUSTOM;
GRANT SELECT,DELETE,UPDATE ON D_DT_INSURANCE TO PROCEDURE I_UP_ADD_CUSTOM;
GRANT SELECT,DELETE ON D_INS_OBJ_RISK_FRANCHISE TO PROCEDURE I_UP_ADD_CUSTOM;
GRANT SELECT,DELETE ON D_DT_INSURANCE_TARIFFS TO PROCEDURE I_UP_ADD_CUSTOM;
GRANT SELECT,DELETE ON O_DT_POLICY_AUTO_USERS TO PROCEDURE I_UP_ADD_CUSTOM;
GRANT SELECT,DELETE ON O_DT_INSURANCE_PARAMS_POLICY TO PROCEDURE I_UP_ADD_CUSTOM;
GRANT SELECT,DELETE ON O_DT_INS_PARAM_COMMON_POLICY TO PROCEDURE I_UP_ADD_CUSTOM;
GRANT SELECT,DELETE ON O_DT_INSURANCE_PARAMS_NS TO PROCEDURE I_UP_ADD_CUSTOM;
GRANT SELECT,DELETE ON O_DT_INSURANCE_PARAMS_GREEN TO PROCEDURE I_UP_ADD_CUSTOM;
GRANT SELECT,DELETE ON O_DT_INSURANCE_PARAMS_OTHER TO PROCEDURE I_UP_ADD_CUSTOM;
GRANT SELECT,DELETE ON O_DT_AUTO_REG_CERTIFICATES TO PROCEDURE I_UP_ADD_CUSTOM;
GRANT SELECT,DELETE ON O_DT_INS_AUTOS TO PROCEDURE I_UP_ADD_CUSTOM;
GRANT SELECT,DELETE ON O_DT_INS_PERSONS TO PROCEDURE I_UP_ADD_CUSTOM;
GRANT SELECT,DELETE ON O_DT_INS_OBJECTS TO PROCEDURE I_UP_ADD_CUSTOM;
GRANT SELECT,INSERT,DELETE ON D_DT_SCHEDULES TO PROCEDURE I_UP_ADD_CUSTOM;
GRANT SELECT,DELETE ON D_DT_AGENTS TO PROCEDURE I_UP_ADD_CUSTOM;
GRANT SELECT,DELETE ON C_SP_PROXY TO PROCEDURE I_UP_ADD_CUSTOM;
GRANT SELECT,DELETE ON D_DT_IMPORTED_DOCS TO PROCEDURE I_UP_ADD_CUSTOM;
GRANT SELECT,DELETE ON D_DT_OFFICE_MEMO_STATES TO PROCEDURE I_UP_ADD_CUSTOM;
GRANT SELECT,DELETE ON D_DT_OFFICE_MEMOS TO PROCEDURE I_UP_ADD_CUSTOM;
GRANT SELECT,UPDATE ON B_DT_BLANKS TO PROCEDURE I_UP_ADD_CUSTOM;
GRANT SELECT,DELETE ON D_DT_INS_COMMON_POLICIES TO PROCEDURE I_UP_ADD_CUSTOM;
GRANT SELECT,DELETE ON D_DT_INS_POLICIES TO PROCEDURE I_UP_ADD_CUSTOM;
GRANT SELECT,DELETE ON D_DT_CONTRACT_CUSTOMERS TO PROCEDURE I_UP_ADD_CUSTOM;
GRANT SELECT ON C_SP_DEPARTMENT TO PROCEDURE I_UP_ADD_CUSTOM;
GRANT SELECT ON B_ADDR_PLACES_KOATUU TO PROCEDURE I_UP_ADD_CUSTOM;
GRANT EXECUTE ON PROCEDURE B_ADDR_FIND_REG_DISTR_KOATUU TO PROCEDURE I_UP_ADD_CUSTOM;
GRANT SELECT ON C_SP_PROXY_CUSTOMERS TO PROCEDURE I_UP_ADD_CUSTOM;
GRANT SELECT ON C_DT_EMPLOYEES TO PROCEDURE I_UP_ADD_CUSTOM;
GRANT SELECT ON D_DT_INS_LOT_POLICIES TO PROCEDURE I_UP_ADD_CUSTOM;
GRANT EXECUTE ON PROCEDURE A_USER_SEL_CURRENT TO PROCEDURE I_UP_ADD_CUSTOM;
GRANT SELECT ON A_USER TO PROCEDURE I_UP_ADD_CUSTOM;
GRANT SELECT ON C_SP_CUSTOMERS TO PROCEDURE I_UP_ADD_CUSTOM;
GRANT SELECT ON C_SP_SALE_POINT_LINKS TO PROCEDURE I_UP_ADD_CUSTOM;
GRANT SELECT ON C_SP_AGENTS TO PROCEDURE I_UP_ADD_CUSTOM;
GRANT SELECT ON C_JN_AGENTS_DOCS TO PROCEDURE I_UP_ADD_CUSTOM;
GRANT SELECT ON C_SP_NATURALS TO PROCEDURE I_UP_ADD_CUSTOM;
GRANT EXECUTE ON PROCEDURE I_UP_ADD_CUSTOMERS TO PROCEDURE I_UP_ADD_CUSTOM;
GRANT EXECUTE ON PROCEDURE D_UP_DT_CONTRACT_CUSTOMERS TO PROCEDURE I_UP_ADD_CUSTOM;
GRANT EXECUTE ON PROCEDURE C_UP_FIND_EMPLOYEE_1C TO PROCEDURE I_UP_ADD_CUSTOM;
GRANT SELECT ON D_INI_INURE_TYPES TO PROCEDURE I_UP_ADD_CUSTOM;
GRANT SELECT ON B_SP_INS_KIND TO PROCEDURE I_UP_ADD_CUSTOM;
GRANT SELECT ON D_SP_INSURANCE_PROGRAMS TO PROCEDURE I_UP_ADD_CUSTOM;
GRANT EXECUTE ON PROCEDURE C_SP_DEPARTMENT_SEL_ID_CHILDS TO PROCEDURE I_UP_ADD_CUSTOM;
GRANT EXECUTE ON PROCEDURE B_UP_DT_BLANKS TO PROCEDURE I_UP_ADD_CUSTOM;
GRANT EXECUTE ON PROCEDURE D_UP_DT_INSURANCE TO PROCEDURE I_UP_ADD_CUSTOM;
GRANT EXECUTE ON PROCEDURE I_UP_ADD_CONTRACTS TO PROCEDURE I_UP_ADD_CUSTOM;
GRANT EXECUTE ON PROCEDURE I_UP_ADD_OBJECTS TO PROCEDURE I_UP_ADD_CUSTOM;
GRANT EXECUTE ON PROCEDURE O_UP_DT_INSURANCE_PARAMS TO PROCEDURE I_UP_ADD_CUSTOM;
GRANT EXECUTE ON PROCEDURE I_UP_ADD_INSURANCE_PARAMS TO PROCEDURE I_UP_ADD_CUSTOM;
GRANT EXECUTE ON PROCEDURE I_UP_ADD_SCHEDULES TO PROCEDURE I_UP_ADD_CUSTOM;
GRANT SELECT ON C_DT_AGENTS_COMM TO PROCEDURE I_UP_ADD_CUSTOM;
GRANT EXECUTE ON PROCEDURE D_UP_DT_AGENTS TO PROCEDURE I_UP_ADD_CUSTOM;

/* Существующие привилегии на эту процедуру */

GRANT EXECUTE ON PROCEDURE I_UP_ADD_CUSTOM TO PROCEDURE I_UP_ADD_CONTRACTS;
GRANT EXECUTE ON PROCEDURE I_UP_ADD_CUSTOM TO CHUYKOV;
GRANT EXECUTE ON PROCEDURE I_UP_ADD_CUSTOM TO ONLINE_VUSO;
GRANT EXECUTE ON PROCEDURE I_UP_ADD_CUSTOM TO "_MTSBU";
GRANT EXECUTE ON PROCEDURE I_UP_ADD_CUSTOM TO AGENT_ROLE;
GRANT EXECUTE ON PROCEDURE I_UP_ADD_CUSTOM TO BACKUP;
GRANT EXECUTE ON PROCEDURE I_UP_ADD_CUSTOM TO CIS_ROLE;
GRANT EXECUTE ON PROCEDURE I_UP_ADD_CUSTOM TO NO_ROLE;
GRANT EXECUTE ON PROCEDURE I_UP_ADD_CUSTOM TO ONLINE_ROLE;
GRANT EXECUTE ON PROCEDURE I_UP_ADD_CUSTOM TO RDB$ADMIN;
GRANT EXECUTE ON PROCEDURE I_UP_ADD_CUSTOM TO SERVICE_ROLE;
GRANT EXECUTE ON PROCEDURE I_UP_ADD_CUSTOM TO WEB_ROLE;