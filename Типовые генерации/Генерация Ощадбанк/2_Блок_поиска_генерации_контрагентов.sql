/*
Генерация Ощадбанк
Блок поиска/генерации контрагентов
Мельников Т.В. 13.06.2016
/**/

execute block
returns (
    ID_CUSTOMER       TINTEGER,      --ID контрагента - найденного/сгенерированного (см. поле NOTE_)
    NOTE             varchar(1000), --Примечание, для информации
    search_name       varchar(1000), --ФИО
    last_name         varchar(1000), --Фамилия
    first_name        varchar(1000), --Имя
    patronimic_name   varchar(1000), --Отчество   
    inn               varchar(1000), --ИНН   
    tel               varchar(1000), --Тел
    date_bir          TDATETIME,     --Дата рождения
    ID_PAYMENT         TINTEGER     --ID платежа

)

as

declare variable KEY_ integer;
declare variable COUNT_CUSTOMER_ integer;
declare variable SEARCH_CUSTOMERS_ varchar(1000);
declare variable ID_CUSTOMER_TYPE T_INTEGER;       --тип контрагента (1 - физическое лицо, 2 - юр.лицо)
declare variable NAME_LEGAL varchar(1000); --Краткое название ЮР лица

begin

--Настройки
KEY_ = 4240;  --Ключ временной таблицы
--Настройки (конец)

  for
  --Цикл по записям временной таблицы
       select --T.INT_FIELD1 as KEY,
        T.INT_FIELD2 as ID_CUSTOMER, --После выполнения этого скрипта, должно быть заполнено ИД-хами контрагентов
        --Контрагент
        t.STR_FIELD4 as CLIENT_FIO,
        t.STR_FIELD13 as LAST_NAME,
        t.STR_FIELD14 as FIRST_NAME,
        t.STR_FIELD15 as PATRONIMIC_NAME,
        t.STR_FIELD7  as CLIENT_INN,
        t.STR_FIELD6  as CLIENT_PHONE,
        t.INT_FIELD2 as ID_PAYMENT,
        t.INT_FIELD7 as ID_CUSTOMER_TYPE


from T_TEMP_TABLE T
where T.INT_FIELD1 = :KEY_ --Ключ
--and t.INT_FIELD4 is null --Предохранитель от двойного прохода
into :ID_CUSTOMER, :search_name, :last_name, :first_name, :patronimic_name, :inn, :tel, :ID_PAYMENT, :ID_CUSTOMER_TYPE
  do
  begin

    ID_CUSTOMER = null;
    NOTE= '';
    SEARCH_CUSTOMERS_ = '';
    date_bir = null;

        --Физ лица
        if (ID_CUSTOMER_TYPE = 1) then begin
            select first 1 SN.ID_CUSTOMER
            from C_SP_NATURALS SN
            where trim(SN.INN) = :inn and
                  upper(trim(SN.LAST_NAME)) = upper(:last_name) and
                  upper(trim(SN.FIRST_NAME)) = upper(:first_name) and
                  upper(trim(SN.PATRONIMIC_NAME)) = upper(:patronimic_name)
                  --Просто берем ID контрагента
            into :ID_CUSTOMER;
            NOTE= 'Найден по ИНН и ФИО. Не создавался.';

            --Работаем с не найденными
            if (ID_CUSTOMER is null) then
            begin
              select count(*)
              from C_SP_NATURALS SN
              where trim(SN.INN) = :inn
              into :COUNT_CUSTOMER_;

              --Генерим ID контрагента
              ID_CUSTOMER =  gen_id(gen_c_sp_customers_id, 1);
               if (COUNT_CUSTOMER_ > 0) then

              begin

              if (COUNT_CUSTOMER_ < 11) then begin
                select list(sn.last_name||' '||sn.first_name||' '||sn.patronimic_name||' '||'ID='||sn.id_customer, '; ')
                from C_SP_NATURALS SN
                where trim(SN.INN) = :inn
                into :SEARCH_CUSTOMERS_;
              end else begin
                 SEARCH_CUSTOMERS_ = COUNT_CUSTOMER_ || 'шт';
              end

                --Добавляем с 0000000000
                insert into c_sp_customers (id_customer, id_customer_type, search_name, id_cust_category, inn_okpo, citizenship, is_valid, DATE_BEG)
                values (:ID_CUSTOMER, 1, :last_name || ' ' || :first_name||' '||:patronimic_name, 6, '0000000000', 1, 30, :date_bir);

                insert into c_sp_naturals (id_customer, last_name, last_name_hash, first_name, first_name_hash, PATRONIMIC_NAME, PATRONIMIC_NAME_HASH, inn, citizenship)
                values (:ID_CUSTOMER, :last_name, (select STR_RET from s_meta_phone_ru(:last_name)),
                :first_name, (select STR_RET from s_meta_phone_ru(:first_name)), :patronimic_name, (select STR_RET from s_meta_phone_ru(:patronimic_name)), '0000000000', 1);
                 NOTE= 'Найден(ы) только по ИНН - '||:SEARCH_CUSTOMERS_||'. Создан с ИНН = 0000000000.';
                 
                --Телефон
                if(trim(:tel) >= 10) then begin
                  insert into C_DT_CONTACT_INFO (ID_PK, ID_CUSTOMER, ID_DEPARTMENT, ID_INFO_TYPE, CONTACT_INFO, MEMO, PHONE_COUNTRY, PHONE_PLACE, PHONE_NUMBER, ID_COUNTRY, MSG_RECIPIENT, ID_TASK, DATE_FROM, DATE_TO)
                  values (gen_id(GEN_C_DT_CONTACT_INFO_ID, 1), :ID_CUSTOMER, null, 10, :tel, null, '380', null, null, 1, 1, null, current_date, '31-DEC-9999');
                end
                --Телефон (Конец)

              end else begin
                --Добавляем такого, какой есть в файле Укргазбанка
                insert into c_sp_customers (id_customer, id_customer_type, search_name, id_cust_category, inn_okpo, citizenship, is_valid, DATE_BEG)
                values (:ID_CUSTOMER, 1, :last_name || ' ' || :first_name||' '||:patronimic_name, 6, :inn, 1, 20, :date_bir);

                insert into c_sp_naturals (id_customer, last_name, last_name_hash, first_name, first_name_hash, PATRONIMIC_NAME, PATRONIMIC_NAME_HASH, inn, citizenship)
                values (:ID_CUSTOMER, :last_name, (select STR_RET from s_meta_phone_ru(:last_name)),
                :first_name, (select STR_RET from s_meta_phone_ru(:first_name)), :patronimic_name, (select STR_RET from s_meta_phone_ru(:patronimic_name)), :inn, 1);
                NOTE= 'Не найден. Создан с ИНН = '||:inn||'.';

                --Телефон
                if(trim(:tel) >= 10) then begin
                  insert into C_DT_CONTACT_INFO (ID_PK, ID_CUSTOMER, ID_DEPARTMENT, ID_INFO_TYPE, CONTACT_INFO, MEMO, PHONE_COUNTRY, PHONE_PLACE, PHONE_NUMBER, ID_COUNTRY, MSG_RECIPIENT, ID_TASK, DATE_FROM, DATE_TO)
                  values (gen_id(GEN_C_DT_CONTACT_INFO_ID, 1), :ID_CUSTOMER, null, 10, :tel, null, '380', null, null, 1, 1, null, current_date, '31-DEC-9999');
                end
                --Телефон (Конец)
              end
            end
        end

       --ЮР лица
       if (ID_CUSTOMER_TYPE = 2) then begin

           select count(*) from c_sp_legals SL where trim(SL.okpo) = :inn into :COUNT_CUSTOMER_;

           if (COUNT_CUSTOMER_ = 1) then begin
              select sl.id_customer, sl.name_full
              from c_sp_legals SL
              where trim(SL.okpo) = :inn
              into :ID_CUSTOMER, :NAME_LEGAL;
              NOTE = 'Найден по ЕГРПО - "'||:NAME_LEGAL||'". Не создавался.';
           end
           ELSE BEGIN
            --Работаем с не найденными
              --Генерим ID контрагента
              ID_CUSTOMER =  gen_id(gen_c_sp_customers_id, 1);
            
                if (COUNT_CUSTOMER_ = 0) then BEGIN
                --Добавляем такого, какой есть в файле Укргазбанка
                insert into c_sp_customers (id_customer, id_customer_type, search_name, id_cust_category, inn_okpo, citizenship, is_valid, DATE_BEG)
                values (:ID_CUSTOMER, 2, :search_name, 6, :inn, 1, 20, null);

                INSERT INTO C_SP_LEGALS (ID_CUSTOMER, IS_LEGAL, NAME_SHORT, NAME_FULL, NAME_SHORT_UKR, NAME_FULL_UKR, NAME_SHORT_INT, NAME_FULL_INT, ID_PROPERTY_TYPE, OKPO, IS_PROFIT_TAX_PAYER, ID_TAX_ITEM, IS_NDS_PAYER, INN, NDS_CERTIF_NUM, NDS_CERTIF_DATE, KIND_OF_ACTIVITY, EMPLOYE_QUANTITY, ID_RESPONSIBLE, IS_TOBO, MTSBU_CODE, MTSBU_DATE_BEG, MTSBU_DATE_END)
                VALUES (:ID_CUSTOMER, NULL, :search_name, :search_name, null, null, NULL, NULL, null, :inn, NULL, NULL, null, null, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL);

                --Телефон
                if(trim(:tel) >= 10) then begin
                  insert into C_DT_CONTACT_INFO (ID_PK, ID_CUSTOMER, ID_DEPARTMENT, ID_INFO_TYPE, CONTACT_INFO, MEMO, PHONE_COUNTRY, PHONE_PLACE, PHONE_NUMBER, ID_COUNTRY, MSG_RECIPIENT, ID_TASK, DATE_FROM, DATE_TO)
                  values (gen_id(GEN_C_DT_CONTACT_INFO_ID, 1), :ID_CUSTOMER, null, 10, :tel, null, '380', null, null, 1, 1, null, current_date, '31-DEC-9999');
                end
                --Телефон (Конец)
                NOTE= 'Не найден. Создан с ЕГРПО = '||:inn||'.';
     end

         if (COUNT_CUSTOMER_ > 1) then BEGIN

                  if (COUNT_CUSTOMER_ < 11) then begin
                    select list(sl.NAME_SHORT, '; ')
                    from c_sp_legals Sl
                    where trim(SL.okpo) = :inn
                    into :SEARCH_CUSTOMERS_;
                  end else begin
                     SEARCH_CUSTOMERS_ = COUNT_CUSTOMER_ || 'шт';
                  end

                    --Добавляем с 00000000
                    insert into c_sp_customers (id_customer, id_customer_type, search_name, id_cust_category, inn_okpo, citizenship, is_valid, DATE_BEG)
                    values (:ID_CUSTOMER, 2, :search_name, 6, '00000000', 1, 30, null);

                    INSERT INTO C_SP_LEGALS (ID_CUSTOMER, IS_LEGAL, NAME_SHORT, NAME_FULL, NAME_SHORT_UKR, NAME_FULL_UKR, NAME_SHORT_INT, NAME_FULL_INT, ID_PROPERTY_TYPE, OKPO, IS_PROFIT_TAX_PAYER, ID_TAX_ITEM, IS_NDS_PAYER, INN, NDS_CERTIF_NUM, NDS_CERTIF_DATE, KIND_OF_ACTIVITY, EMPLOYE_QUANTITY, ID_RESPONSIBLE, IS_TOBO, MTSBU_CODE, MTSBU_DATE_BEG, MTSBU_DATE_END)
                    VALUES (:ID_CUSTOMER, NULL, :search_name, :search_name, null, null, NULL, NULL, null, '00000000', NULL, NULL, null, null, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL);

                    --Телефон
                    if(trim(:tel) >= 10) then begin
                      insert into C_DT_CONTACT_INFO (ID_PK, ID_CUSTOMER, ID_DEPARTMENT, ID_INFO_TYPE, CONTACT_INFO, MEMO, PHONE_COUNTRY, PHONE_PLACE, PHONE_NUMBER, ID_COUNTRY, MSG_RECIPIENT, ID_TASK, DATE_FROM, DATE_TO)
                      values (gen_id(GEN_C_DT_CONTACT_INFO_ID, 1), :ID_CUSTOMER, null, 10, :tel, null, '380', null, null, 1, 1, null, current_date, '31-DEC-9999');
                    end
                    --Телефон (Конец)
                    NOTE= 'Найдены по ЕГРПО - '||:SEARCH_CUSTOMERS_||'. Создан с ЕГРПО = 00000000.';
         end

        end

    end

    --Те, кого не удалось определить из суммы
    if (ID_CUSTOMER_TYPE = 0) then begin
        NOTE= 'Тип контрагента не определен. Контрагент не создан. Договор не будет сгенерирован.';
    end

    --Обновляем временную таблицу
    update T_TEMP_TABLE T
    set t.INT_FIELD4 = :ID_CUSTOMER
    where T.INT_FIELD1 = :KEY_ and
          t.INT_FIELD2 = :ID_PAYMENT;
    --Обновляем временную таблицу (Конец)
    suspend;
  end
end



/* --Проверка
select
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