/*
Генерация ВОГ
4_Генерация_договоров
Мельников Т.В. 04.06.2016
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


begin
  --Настройки
  TEMP_KEY     = 4240; --Ключ временной таблицы
  m_generation = X;    --месяц генерации
  y_generation = 201X; --год генерации

  --Получаем дату закрытого периода
  select closed_period from sys_options into :closed_period;

  --Генерация договоров
  for select 
      TT.INT_FIELD2 as ID_NUMBER,
      TT.INT_FIELD3 as ID_BLANK,
      TT.INT_FIELD4 as id_customer,
      TT.CURR_FIELD1 as INSURANCE_PAYMENT
      from T_TEMP_TABLE TT
      where TT.INT_FIELD1 = :TEMP_KEY
	  and TT.INT_FIELD5 is null
      order by TT.INT_FIELD2
      into :ID_NUMBER, :ID_BLANK, :id_customer, :INSURANCE_PAYMENT
  do
  begin

     --Получение номера бланка
     select db.number from B_DT_BLANKS db where db.id_blank = :id_blank
     into :blank_number;
     
     --Генерация ID договора
     id_doc = gen_id(get_d_document, 1);
     ID_INSURANCE = gen_id(GEN_O_DT_INSURANCE_PARAMS_ID, 1); --ИД параметра
     ID_OBJ = gen_id(GEN_O_DT_INS_OBJ_ID, 1); --ИД обекта

     --Получаем случайную дату для договора
     if (m_generation  in (1, 3, 5, 7, 8, 10, 12))   then begin
        date_doc =  CAST(round(rand()*1000/33+1)||'.'||m_generation||'.'||y_generation AS date);   --31 день
     end
     if (m_generation  in (4, 6, 9, 11))   then begin
        date_doc =  CAST(round(rand()*1000/34+1)||'.'||m_generation||'.'||y_generation AS date);   --30 дней
     end
     if (m_generation  in (2))   then begin
        date_doc =  CAST(round(rand()*1000/38+1)||'.'||m_generation||'.'||y_generation AS date);   --28 дней
     end
	 
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


--99----------------------------------------------
     if (:INSURANCE_PAYMENT = 99) then begin

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
        :id_doc, :blank_number, :blank_number|| '-33-05-00', :date_doc, :id_contract_customer_native, --(-07-05-00 и -02-05-00)
        :id_contract_customer, 10, 0, :id_blank, 4, --(9 и 2) !!!!!!!!!!!!
        :DATE_DOC, dateadd(1 year TO :DATE_DOC), 365, 97692, 96,
        null, 3, 1831354, 1831354, 'Генерация ВОГ',
        1831354, current_timestamp,         iif(:closed_period >= :date_doc, 1, 0),
        iif(:closed_period >= :date_doc, maxvalue(:closed_period + 1, :date_doc), null),
        iif(:closed_period >= :date_doc, maxvalue(:closed_period + 1, :date_doc), null),
        iif(:closed_period >= :date_doc, maxvalue(:closed_period + 1, dateadd(1 year TO :DATE_DOC)), null), 3, 1, current_timestamp, 96
      );

      insert into d_dt_insurance (id_doc, id_ins_kind, rate_of_exchange, sum_doc, insurance_sum, bonus, id_sale_channel,
        insurance_year, credit_year, id_schedule_type, rate_of_exchange_euro, internal_reinsurance, reserve_payments, VALID_COST, ID_VALID_COST_CURRENCY, ID_INSURANCE_SUM_CURRENCY, ID_CONTRACT_BENEFICIARY)
      values (:id_doc, 47, (select  CR.RATE/100 from B_SP_CURRENCIES_RATE CR where CR.ID_CURRENCY_FROM = 840 and :date_doc between CR.ACTUAL_DATE_FROM and  cr.actual_date_to), 99, 40000, 1, 115,
        1, 1, 2, (select  CR.RATE/100 from B_SP_CURRENCIES_RATE CR where CR.ID_CURRENCY_FROM = 978 and :date_doc between CR.ACTUAL_DATE_FROM and  cr.actual_date_to), 38.76, 31.01, 40000, 980, 980, :ID_CONTRACT_BENEFICIARY
      );

      --Расширение договоров страхования для добровольной автогражданки      
      INSERT INTO D_DT_INS_COMMON_VCL (ID_DOC, CONTRACT_TYPE, ID_BASED_BY_POLICY, BASED_BY_POLICY_SER_NUM, BASED_BY_POLICY_DATE)
      VALUES (:id_doc, 1, NULL, NULL, NULL);      
      
     --Объекты
      INSERT INTO O_DT_INS_OBJECTS
      (ID_OBJ, OBJ_NAME, OBJ_ITEM_NUM, ID_TYPE, ID_OWNER, ID_OWNER_OBJ, ID_OBJ_STATE, OBJ_VALID_COST, VALID_COST_CURRENCY, OBJ_INSURANCE_SUM, INSURANCE_SUM_CURRENCY, OBJ_FRANCHISE, OBJ_INSURANCE_TARIFF, OBJ_INSURANCE_PAYMENT, BONUS, LINK_TO, IS_EXPORTED, ERROR_1C)
      VALUES
      (:ID_OBJ, 'Автомобиль', NULL, 1, :ID_CUSTOMER, NULL, 20, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

     --Параметры страхования
     INSERT INTO O_DT_INSURANCE_PARAMS
       (ID_INSURANCE, ID_DOC, ID_OBJECT_BENEFICIARY, ID_OBJ, OBJECTS_COUNT, OBJ_ITEM_NUM, REAL_INSURANCE_SUM, ID_REAL_INS_SUM_CURRENCY, OBJ_VALID_COST, ID_OBJ_VALID_COST_CURRENCY, OBJ_INSURANCE_SUM, ID_OBJ_INSURANCE_SUM_CURRENCY, OBJ_CREDIT_AMOUNT, ID_OBJ_CREDIT_AMOUNT_CURRENCY, FRANCHISE_PER, FRANCHISE_CUR, FRANCHISE_MINIMUM, INSURANCE_TARIFF, CALC_INSURANCE_TARIFF, IS_DEPENDS_TARIFF_ON_COMM, INSURANCE_PAYMENT, INSURANCE_PAYMENT_CALC, ID_PACKAGE, IS_CHANGED_PACKAGE, ID_PARENT, ID_TARIFF_MEMBER, K_FAKE, K0, FRANCHISE, IS_REQUIRED_PROP_INT, CUST_PROP_INTEREST, LOADING, ORIGINAL_INSURANCE_TARIFF, ORIGINAL_INSURANCE_PAYMENT, IS_OVERPAY, INTERNAL_REINSURANCE_CUR, INTERNAL_REINSURANCE_PER, RESERVE_PAYMENTS_CUR, RESERVE_PAYMENTS_PER, K_PAYMENT_PARTITION, ID_PROGRAM, K_UNDERWRITING)
     VALUES
       (:ID_INSURANCE,        :ID_DOC,  null, :ID_OBJ,         1, 1,              NULL, NULL, 40000,     NULL, 40000,     NULL, NULL, NULL, NULL, NULL, NULL, 0.2475, 0.2475, NULL, 99,         null, 32, 0, NULL, 20701, 1, 1, NULL, null, NULL, 50, null, 99,   0, 38.76, 0.0969, 31.01, 0.07752, 1, NULL, 1);
    
     --Расширение параметров страхования для добровольного страхования ответственности
     INSERT INTO O_DT_INS_PARAM_COMMON_VCL (ID_INSURANCE, LIFE_LIMIT, PROPERTY_LIMIT, VICTIM_LIMIT, EVENT_LIMIT)
     VALUES (:ID_INSURANCE, 20000, 20000, 4000, NULL);

     --Расширение параметров страхования для добровольного страхования автогражданки
     INSERT INTO O_DT_INSURANCE_PARAMS_VCL (ID_INSURANCE, K1, K2, K3, K4, K5, IS_PROPORTION_INS_PAYMENT, AUTO_COVERING_TERRITORY, AUTO_USE_FEATURE, INSURANCE_EVENTS_COUNT, INSURANCE_COMPENSATION, ENABLED_CATEGORIES, ID_SPEC_EQUIPMENT_TYPE, ID_REGISTRATION_PLACE, K6, AUTO_USAGE_MONTHS, REGISTRATION_PLACE_STRING)
     VALUES (:ID_INSURANCE, 1, 1, 1, 1, 1, NULL, NULL, 0, 0, NULL, NULL, NULL, NULL, 1, '000000000000', NULL);

     --Тарифы для договора
     INSERT INTO D_DT_INSURANCE_TARIFFS (ID_INSURANCE_TARIFF, ID_OBJ, INSURANCE_YEAR, INSURANCE_TARIFF, INSURANCE_PAYMENT, INSURANCE_AMOUNT, ORIGINAL_INSURANCE_TARIFF, ORIGINAL_INSURANCE_PAYMENT, INTERNAL_REINSURANCE_CUR, INTERNAL_REINSURANCE_PER, RESERVE_PAYMENTS_CUR, RESERVE_PAYMENTS_PER) 
     VALUES (gen_id(GEN_ID_INSURANCE_TARIFF, 1), :ID_INSURANCE, EXTRACT(YEAR FROM :date_doc), 0.2475, 99, 40000, NULL, NULL, 38.76, 0.0969, 31.01, 0.07752);
     
     --Риски
     INSERT INTO d_ins_obj_risk_franchise (ID_OBJ_RISK, ID_OBJ, ID_RISK, IS_PRESENT, ID_FRANCHISE_TYPE, FRANCHISE, FRANCHISE_CURRENCY, FRANCHISE_DAY, LIMIT, REAL_FRANCHISE, INSURANCE_TARIFF, INSURANCE_PAYMENT, INSURANCE_SUM, SUM_CURRENCY, INS_TARIFF, ID_RE_OBJ)
     VALUES (gen_id(GEN_OBJ_RISK_FRANCHISE, 1), :ID_INSURANCE, 118, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

     INSERT INTO d_ins_obj_risk_franchise (ID_OBJ_RISK, ID_OBJ, ID_RISK, IS_PRESENT, ID_FRANCHISE_TYPE, FRANCHISE, FRANCHISE_CURRENCY, FRANCHISE_DAY, LIMIT, REAL_FRANCHISE, INSURANCE_TARIFF, INSURANCE_PAYMENT, INSURANCE_SUM, SUM_CURRENCY, INS_TARIFF, ID_RE_OBJ)
     VALUES (gen_id(GEN_OBJ_RISK_FRANCHISE, 1), :ID_INSURANCE, 182, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

     --Плановый платеж
     INSERT INTO d_dt_schedules (ID_SCHEDULE, ID_DOC_INFO, SCHEDULE_DATE, SCHEDULE_SUM, ID_SCHEDULE_TYPE, BALANCE_SUM, ID_FACT_PAYMENT, IS_LAST_IN_DAY) 
     VALUES (gen_id(GET_D_SCHEDULE, 1), :ID_DOC, :DATE_DOC, 99, 0, null, NULL, 1);

     end


--199----------------------------------------------
     if (:INSURANCE_PAYMENT = 199) then begin

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
        :id_doc, :blank_number, :blank_number|| '-07-05-00', :date_doc, :id_contract_customer_native, --(-07-05-00 и -02-05-00)
        :id_contract_customer, 9, 0, :id_blank, 4, --(9 и 2) !!!!!!!!!!!!
        :DATE_DOC, dateadd(1 year TO :DATE_DOC), 365, 97692, 96,
        null, 3, 1831354, 1831354, 'Генерация ВОГ',
        1831354, current_timestamp,         iif(:closed_period >= :date_doc, 1, 0),
        iif(:closed_period >= :date_doc, maxvalue(:closed_period + 1, :date_doc), null),
        iif(:closed_period >= :date_doc, maxvalue(:closed_period + 1, :date_doc), null),
        iif(:closed_period >= :date_doc, maxvalue(:closed_period + 1, dateadd(1 year TO :DATE_DOC)), null), 3, 1, current_timestamp, 96
      );

      insert into d_dt_insurance (id_doc, id_ins_kind, rate_of_exchange, sum_doc, insurance_sum, bonus, id_sale_channel,
        insurance_year, credit_year, id_schedule_type, rate_of_exchange_euro, internal_reinsurance, reserve_payments, VALID_COST, ID_VALID_COST_CURRENCY, ID_INSURANCE_SUM_CURRENCY, ID_CONTRACT_BENEFICIARY)
      values (:id_doc, 54, (select  CR.RATE/100 from B_SP_CURRENCIES_RATE CR where CR.ID_CURRENCY_FROM = 840 and :date_doc between CR.ACTUAL_DATE_FROM and  cr.actual_date_to), 199, 1000, 1, 115,
        1, 1, 2, (select  CR.RATE/100 from B_SP_CURRENCIES_RATE CR where CR.ID_CURRENCY_FROM = 978 and :date_doc between CR.ACTUAL_DATE_FROM and  cr.actual_date_to), 55.72, 44.58, 1000, 980, 980, :ID_CONTRACT_BENEFICIARY
      );

     --Объекты
      INSERT INTO O_DT_INS_OBJECTS
      (ID_OBJ, OBJ_NAME, OBJ_ITEM_NUM, ID_TYPE, ID_OWNER, ID_OWNER_OBJ, ID_OBJ_STATE, OBJ_VALID_COST, VALID_COST_CURRENCY, OBJ_INSURANCE_SUM, INSURANCE_SUM_CURRENCY, OBJ_FRANCHISE, OBJ_INSURANCE_TARIFF, OBJ_INSURANCE_PAYMENT, BONUS, LINK_TO, IS_EXPORTED, ERROR_1C)
      VALUES
      (:ID_OBJ, null, NULL, 5, :ID_CUSTOMER, NULL, 20, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

      --Параметры страхования
     INSERT INTO O_DT_INSURANCE_PARAMS
       (ID_INSURANCE, ID_DOC, ID_OBJECT_BENEFICIARY, ID_OBJ, OBJECTS_COUNT, OBJ_ITEM_NUM, REAL_INSURANCE_SUM, ID_REAL_INS_SUM_CURRENCY, OBJ_VALID_COST, ID_OBJ_VALID_COST_CURRENCY, OBJ_INSURANCE_SUM, ID_OBJ_INSURANCE_SUM_CURRENCY, OBJ_CREDIT_AMOUNT, ID_OBJ_CREDIT_AMOUNT_CURRENCY, FRANCHISE_PER, FRANCHISE_CUR, FRANCHISE_MINIMUM, INSURANCE_TARIFF, CALC_INSURANCE_TARIFF, IS_DEPENDS_TARIFF_ON_COMM, INSURANCE_PAYMENT, INSURANCE_PAYMENT_CALC, ID_PACKAGE, IS_CHANGED_PACKAGE, ID_PARENT, ID_TARIFF_MEMBER, K_FAKE, K0, FRANCHISE, IS_REQUIRED_PROP_INT, CUST_PROP_INTEREST, LOADING, ORIGINAL_INSURANCE_TARIFF, ORIGINAL_INSURANCE_PAYMENT, IS_OVERPAY, INTERNAL_REINSURANCE_CUR, INTERNAL_REINSURANCE_PER, RESERVE_PAYMENTS_CUR, RESERVE_PAYMENTS_PER, K_PAYMENT_PARTITION, ID_PROGRAM, K_UNDERWRITING)
     VALUES
       (:ID_INSURANCE, :ID_DOC, null, :ID_OBJ, 1, 1, NULL, NULL, 1000, NULL, 1000, NULL, NULL, NULL, NULL, NULL, NULL, 19.9, 19.9, NULL, 199, null, null, 0, NULL, 20790, 1, 1, NULL, null, NULL, 50, 19.9, 199,   null, 55.72, 28, 44.58, 22.4, 1, NULL, 1);


     --Таблица параметров страхования для договоров стахования финрисков    
     INSERT INTO o_dt_insurance_params_fr (ID_INSURANCE, NOTARY_NAME, REGISTRY_NUM, CUST_PROP_INTEREST, IS_REQUIRED_PROP_INT) 
     VALUES (:ID_INSURANCE, NULL, NULL, NULL, NULL);


     --Тарифы для договора
     INSERT INTO D_DT_INSURANCE_TARIFFS (ID_INSURANCE_TARIFF, ID_OBJ, INSURANCE_YEAR, INSURANCE_TARIFF, INSURANCE_PAYMENT, INSURANCE_AMOUNT, ORIGINAL_INSURANCE_TARIFF, ORIGINAL_INSURANCE_PAYMENT, INTERNAL_REINSURANCE_CUR, INTERNAL_REINSURANCE_PER, RESERVE_PAYMENTS_CUR, RESERVE_PAYMENTS_PER) 
     VALUES (gen_id(GEN_ID_INSURANCE_TARIFF, 1), :ID_INSURANCE, EXTRACT(YEAR FROM :date_doc), 19.9, 199, 1000, 19.9, 199, 55.72, 28, 44.58, 22.4);
     
     --Риски
     INSERT INTO d_ins_obj_risk_franchise (ID_OBJ_RISK, ID_OBJ, ID_RISK, IS_PRESENT, ID_FRANCHISE_TYPE, FRANCHISE, FRANCHISE_CURRENCY, FRANCHISE_DAY, LIMIT, REAL_FRANCHISE, INSURANCE_TARIFF, INSURANCE_PAYMENT, INSURANCE_SUM, SUM_CURRENCY, INS_TARIFF, ID_RE_OBJ)
     VALUES (gen_id(GEN_OBJ_RISK_FRANCHISE, 1), :ID_INSURANCE, 346, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

     --Плановый платеж
     INSERT INTO d_dt_schedules (ID_SCHEDULE, ID_DOC_INFO, SCHEDULE_DATE, SCHEDULE_SUM, ID_SCHEDULE_TYPE, BALANCE_SUM, ID_FACT_PAYMENT, IS_LAST_IN_DAY) 
     VALUES (gen_id(GET_D_SCHEDULE, 1), :ID_DOC, :DATE_DOC, 199, 0, null, NULL, 1);


     end



--499----------------------------------------------
     if (:INSURANCE_PAYMENT = 499) then begin


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
        :id_doc, :blank_number, :blank_number|| '-02-05-00', :date_doc, :id_contract_customer_native, --(-07-05-00 и -02-05-00)
        :id_contract_customer, 2, 0, :id_blank, 4, --(9 и 2) !!!!!!!!!!!!
        :DATE_DOC, dateadd(1 year TO :DATE_DOC), 365, 97692, 96,
        null, 3, 1831354, 1831354, 'Генерация ВОГ',
        1831354, current_timestamp,         iif(:closed_period >= :date_doc, 1, 0),
        iif(:closed_period >= :date_doc, maxvalue(:closed_period + 1, :date_doc), null),
        iif(:closed_period >= :date_doc, maxvalue(:closed_period + 1, :date_doc), null),
        iif(:closed_period >= :date_doc, maxvalue(:closed_period + 1, dateadd(1 year TO :DATE_DOC)), null), 3, 1, current_timestamp, 96
      );

      insert into d_dt_insurance (id_doc, id_ins_kind, rate_of_exchange, sum_doc, insurance_sum, bonus, id_sale_channel,
        insurance_year, credit_year, id_schedule_type, rate_of_exchange_euro, internal_reinsurance, reserve_payments, VALID_COST, ID_VALID_COST_CURRENCY, ID_INSURANCE_SUM_CURRENCY, ID_CONTRACT_BENEFICIARY)
      values (:id_doc, 41, (select  CR.RATE/100 from B_SP_CURRENCIES_RATE CR where CR.ID_CURRENCY_FROM = 840 and :date_doc between CR.ACTUAL_DATE_FROM and  cr.actual_date_to), 499, 20000, 1, 115,
        1, 1, 2, (select  CR.RATE/100 from B_SP_CURRENCIES_RATE CR where CR.ID_CURRENCY_FROM = 978 and :date_doc between CR.ACTUAL_DATE_FROM and  cr.actual_date_to), null, null, 20000, 980, 980, :ID_CONTRACT_BENEFICIARY
      );
      
      
      
     --Расширение договоров страхования для добровольного наземного страхования  
     INSERT INTO d_dt_ins_nt (ID_DOC, ID_BASED_BY_POLICY, BASED_BY_POLICY_SER_NUM, BASED_BY_POLICY_DATE)
     VALUES (:id_doc, NULL, NULL, NULL);
      

     --Объекты
      INSERT INTO O_DT_INS_OBJECTS
      (ID_OBJ, OBJ_NAME, OBJ_ITEM_NUM, ID_TYPE, ID_OWNER, ID_OWNER_OBJ, ID_OBJ_STATE, OBJ_VALID_COST, VALID_COST_CURRENCY, OBJ_INSURANCE_SUM, INSURANCE_SUM_CURRENCY, OBJ_FRANCHISE, OBJ_INSURANCE_TARIFF, OBJ_INSURANCE_PAYMENT, BONUS, LINK_TO, IS_EXPORTED, ERROR_1C)
      VALUES
      (:ID_OBJ, 'Автомобиль', NULL, 1, :ID_CUSTOMER, NULL, 20, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

      --Параметры страхования
     INSERT INTO O_DT_INSURANCE_PARAMS
       (ID_INSURANCE, ID_DOC, ID_OBJECT_BENEFICIARY, ID_OBJ, OBJECTS_COUNT, OBJ_ITEM_NUM, REAL_INSURANCE_SUM, ID_REAL_INS_SUM_CURRENCY, OBJ_VALID_COST, ID_OBJ_VALID_COST_CURRENCY, OBJ_INSURANCE_SUM, ID_OBJ_INSURANCE_SUM_CURRENCY, OBJ_CREDIT_AMOUNT, ID_OBJ_CREDIT_AMOUNT_CURRENCY, FRANCHISE_PER, FRANCHISE_CUR, FRANCHISE_MINIMUM, INSURANCE_TARIFF, CALC_INSURANCE_TARIFF, IS_DEPENDS_TARIFF_ON_COMM, INSURANCE_PAYMENT, INSURANCE_PAYMENT_CALC, ID_PACKAGE, IS_CHANGED_PACKAGE, ID_PARENT, ID_TARIFF_MEMBER, K_FAKE, K0, FRANCHISE, IS_REQUIRED_PROP_INT, CUST_PROP_INTEREST, LOADING, ORIGINAL_INSURANCE_TARIFF, ORIGINAL_INSURANCE_PAYMENT, IS_OVERPAY, INTERNAL_REINSURANCE_CUR, INTERNAL_REINSURANCE_PER, RESERVE_PAYMENTS_CUR, RESERVE_PAYMENTS_PER, K_PAYMENT_PARTITION, ID_PROGRAM, K_UNDERWRITING)
     VALUES
       (:ID_INSURANCE, :ID_DOC, null, :ID_OBJ, 1, 1, NULL, NULL, 20000, NULL, 20000, NULL, NULL, NULL, NULL, NULL, NULL, 2.495, 2.495, NULL, 499, null, 324, 0, NULL, 20698, 1, 1, NULL, null, NULL, 57, 2.495, 499, 0, null, null, null, null, 1, NULL, 1);


     --Таблица параметров страхования для договоров стахования финрисков    
     INSERT INTO o_dt_insurance_params_fr (ID_INSURANCE, NOTARY_NAME, REGISTRY_NUM, CUST_PROP_INTEREST, IS_REQUIRED_PROP_INT) 
     VALUES (:ID_INSURANCE, NULL, NULL, NULL, NULL);


     --Тарифы для договора
     INSERT INTO D_DT_INSURANCE_TARIFFS (ID_INSURANCE_TARIFF, ID_OBJ, INSURANCE_YEAR, INSURANCE_TARIFF, INSURANCE_PAYMENT, INSURANCE_AMOUNT, ORIGINAL_INSURANCE_TARIFF, ORIGINAL_INSURANCE_PAYMENT, INTERNAL_REINSURANCE_CUR, INTERNAL_REINSURANCE_PER, RESERVE_PAYMENTS_CUR, RESERVE_PAYMENTS_PER) 
     VALUES (gen_id(GEN_ID_INSURANCE_TARIFF, 1), :ID_INSURANCE, EXTRACT(YEAR FROM :date_doc), 2.495, 499, 20000, null, null, null, null, null, null);
     
     --Риски
     INSERT INTO d_ins_obj_risk_franchise (ID_OBJ_RISK, ID_OBJ, ID_RISK, IS_PRESENT, ID_FRANCHISE_TYPE, FRANCHISE, FRANCHISE_CURRENCY, FRANCHISE_DAY, LIMIT, REAL_FRANCHISE, INSURANCE_TARIFF, INSURANCE_PAYMENT, INSURANCE_SUM, SUM_CURRENCY, INS_TARIFF, ID_RE_OBJ)
     VALUES (gen_id(GEN_OBJ_RISK_FRANCHISE, 1), :ID_INSURANCE, 27, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);


     --Таблица параметров страхования для НТ по объекту страхования - автомобиль
     INSERT INTO O_DT_INSURANCE_PARAMS_NT (ID_INSURANCE, K1, K2, K3, K4, K5, K6, K7, K8, K9, K10, K11, K12, K13, K14, K15, K16, K17, K18, K19, K20, K21, K22, K23, AUTO_RUN, ID_AUTO_TYPE, ID_AUTO_COVERING_TERRITORY, ID_USE_FEATURE, ID_REFUND_CONDITION, ID_SPECIAL_CONDITION, ID_REFUND_REASON, HAS_ROLLOVER_RISK, HAS_SATELLITE_SYSTEMS, DATE_BEG, DATE_END, FRANCHISE_CUR_LOSS, RATE_OF_EXCHANGE, DOCUMENTS, POSSIBLE_ITEMS_PARKING, ID_AUTO_INSPECTION, PRESENCE_DAMAGES, PRESENCE_DAMAG_LAST_YEAR, TRAFFIC_RULES, ID_CAN_DRIVE_COUNT, ID_STD_EXCESS, ID_PAYMENT_WITHOUT_CALL, ID_PAYMENT_WITHOUT_REF, LOADING, FRANCHISE_STEAL_DEATH, VALID_COST_NOT_DEFINED, ID_EXPERT, EXPERTISE_DATE, REGISTRATION_PLACE, REPORT_ITEMS, IS_NOT_AGGREGETE_SUM, VEHICLE_INSURANCE_SUM, VEHICLE_REAL_COST, OPTION_INDEMNITY, ID_AUTO_COVERING_PLACE, ID_AUTO_RUN_LIMIT, ID_DRIVER_EXPERIENCE, ID_ANTI_THEFT_TYPE, ID_PARKING_AREA, EVACUATION_INCLUDED, ID_DRIVERS_AGES) 
     VALUES (:ID_INSURANCE, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, NULL, NULL, 0, NULL, 1, 1, NULL, NULL, 3, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 5, 2, NULL, 1, 4, NULL, NULL, 0, NULL, NULL, NULL, 0, 0, 20000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL);


    --Таблица информации по объекту страхования - автомобилю     
     INSERT INTO O_DT_INS_AUTOS (ID_OBJ, ID_AUTO_MODEL, ID_AUTO_CATEGORY, ID_AUTO_TYPE, ID_DRIVE_TYPE, ID_COUNTRY, COMPLECTATION, BODY_NUM, CHASSIS_NUM, AUTO_NUMBER, AUTO_LOG_SERIES, AUTO_LOG_NUMBER, MANUFACT_YEAR, MANUFACT_MONTH, CORRECTION_MANUFACT_YEAR, ENGINE_VOLUME, CARRYING_CAPACITY, BOARDING_PLACES_COUNT, AUTO_COST, ID_AUTO_VERSION, AUTO_MODEL_STRING, ID_AUTO_BODY_KIND, ID_AUTO_CAPACITY, BODY_NUM_SEARCH) 
     VALUES (:ID_OBJ, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Автомобиль', NULL, NULL, NULL);

     --Плановый платеж
     INSERT INTO d_dt_schedules (ID_SCHEDULE, ID_DOC_INFO, SCHEDULE_DATE, SCHEDULE_SUM, ID_SCHEDULE_TYPE, BALANCE_SUM, ID_FACT_PAYMENT, IS_LAST_IN_DAY) 
     VALUES (gen_id(GET_D_SCHEDULE, 1), :ID_DOC, :DATE_DOC, 499, 0, null, NULL, 1);

     end

    --Обновление временной таблицы
    update T_TEMP_TABLE TT
    set TT.INT_FIELD5 = :id_doc
    where TT.INT_FIELD1 = :TEMP_KEY and
          TT.INT_FIELD2 = :ID_NUMBER;

  end

end

/* --Проверка
select
--TT.INT_FIELD1 as TEMP_KEY,
TT.INT_FIELD2 as ID_NUMBER,
TT.INT_FIELD3 as ID_BLANK,
TT.INT_FIELD4 as id_customer,
TT.INT_FIELD5 as id_doc,
TT.CURR_FIELD1 as INSURANCE_PAYMENT
from T_TEMP_TABLE TT
where TT.INT_FIELD1 = 4240
order by TT.INT_FIELD2  
/**/ 