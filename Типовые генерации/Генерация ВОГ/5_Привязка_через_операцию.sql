/*
Генерация ВОГ 
5_Привязка_через_операцию (тип: Зачет Ск-а - Ск)
Мельников Т.В. 06.06.2016
/**/

execute block as
declare variable TEMP_KEY integer; --Ключ временной таблицы
declare variable ID_NUMBER integer; --Виртуальный ID записей
declare variable id_doc tinteger;
declare variable ins_pay tmoney;
declare variable ID_PAYMENT_PART TINTEGER;  --ID платежа-части ВОГ РИТЕЙЛ
declare variable ID_OPERATION TINTEGER;     --ИД операции
declare variable ID_PAYMENT_WOG TINTEGER;   --ID платежа ВОГ РИТЕЙЛ
declare variable fact_sum_wog TNUMERIC16_2; --Полная сумма платежа ВОГ
declare variable CF_DATE_WOG TDATE;         --Дата платежа ВОГ
declare variable id_doc_wog tinteger;       --ID агентского договора ВОГ
declare variable id_customer_wog tinteger;  --ID контрагента ВОГ
declare variable sum_operation tmoney;      --Полная сумма операции
declare variable DATE_OPERATION TDATE;      --Дата операции
declare variable DESCRIPTION TVARCHAR400;   --Описание
declare variable ID_OFFSET_DEAL tinteger;
declare variable id_customer tinteger;

begin

Этот скрипт создает по 500 договоров в одной операции. Если договоров, больше 500, нужно запускать несколько раз. Например 1020 договоров - 3 запуска (500+500+20=1020)

--Настройки
TEMP_KEY       = 4240;         --Ключ временной таблицы
ID_PAYMENT_WOG = XXXXXXX;      --ID платежа ВОГ РИТЕЙЛ
DATE_OPERATION = 'XX.XX.201X'; --Последний день периода генерации
--Не обязательно. Если NULL, то автоматически. 
--DESCRIPTION    = --'Привязка агентского платежа ВОГ РИТЕЙЛ от 30.06.2016 г. к активированным коробочным договорам страхования (генерация)';
 
--Вычисляем ID агентского договора и ID контрагента ВОГ из платежа.
select pa.id_customer, pa.id_doc, cf.cf_date, pa.fact_sum from f_dt_payments pa
join f_dt_cash_flow cf on cf.id_cash_flow = pa.id_cash_flow
where pa.id_payment = :ID_PAYMENT_WOG
into :id_customer_wog, :id_doc_wog, :CF_DATE_WOG, :fact_sum_wog;

--Вычисляем общую сумму операции из временной таблицы
select sum(T.CURR_FIELD1) from 
(select
TT.CURR_FIELD1
from T_TEMP_TABLE TT
where TT.INT_FIELD1 = :TEMP_KEY
and TT.INT_FIELD6 is null
order by TT.INT_FIELD2 --Обязательная сортировка по "индексу" тут и в проходе по таблице (строка 79)
rows 1 to 500 --Берем только 500
) t
into :sum_operation;

if (:sum_operation is not null) then begin

	--Описание операции
	if (:DESCRIPTION is null) then begin
	  --DESCRIPTION = 'Привязка части платежа ООО "ВОГ РИТЕЙЛ" (ID='||:ID_PAYMENT_WOG||' от '||:CF_DATE_WOG||' на общ. сумму '||:fact_sum_wog||' грн.) в сумме '||:sum_operation||' грн. к сгенерированным договорам страхования';
	  DESCRIPTION = 'Привязка агентского платежа ВОГ РИТЕЙЛ от '||:CF_DATE_WOG||' г. к активированным коробочным договорам страхования (генерация)';
	end

	ID_OPERATION = gen_id(GEN_F_DT_OPERATIONS, 1);
	 
	--Документы реестра операций
	INSERT INTO F_DT_OPERATIONS (ID_OPERATION, ID_TYPE_OPERATION, ID_STATE_OPERATION, DATE_BEG, DATE_END, SUMMA, DESCRIPTION, NOTE, ID_PAY_ABSTRACT, DATE_EDIT, ID_CUSTOMER_EDIT, IS_UPLOAD_EXTERNAL_SYSTEM) 
	VALUES (:ID_OPERATION, 12, 1, :DATE_OPERATION, :DATE_OPERATION, :sum_operation, :DESCRIPTION, NULL, NULL, NULL, NULL, 1);
	 
	 for
	--Получение контрагентов, ID договоров и сумм платежей из временной таблицы:
	select tt.int_field2,
	  TT.INT_FIELD5 as id_doc,
	  TT.CURR_FIELD1 as INSURANCE_PAYMENT,
	  TT.INT_FIELD6 as id_payment,
	  TT.INT_FIELD4 as id_customer

	from T_TEMP_TABLE TT
	where TT.INT_FIELD1 = :TEMP_KEY
	and TT.INT_FIELD6 is null
	order by TT.INT_FIELD2 --Обязательная сортировка по "индексу" тут и в рассчете суммы (строка 49)
	rows 1 to 500  --Берем только 500
	into :ID_NUMBER, :id_doc, :ins_pay, :ID_PAYMENT_PART, :id_customer

	 do
	begin

		--Реестр зачетов страховых платежей
		--Прибутки. Их столько, сколько договоров
		ID_OFFSET_DEAL = gen_id(GEN_F_UP_DT_OFFSET_DEAL_ID, 1);
		INSERT INTO f_dt_offset_deals (ID_OFFSET_DEAL, OD_DATE, OD_SUM, ID_CUSTOMER, ID_CF_TYPE, ID_DOC, ID_DOC_1C, ID_DOC_CLAIM, ID_OPERATION, ID_CL_TYPE, ID_PAYMENT, IS_FIXED, ID_PAY_DIRECTION, ID_REGRESS, CF_REPAYMENT)
		VALUES (:ID_OFFSET_DEAL, :DATE_OPERATION, :ins_pay, :id_customer, 26, :id_doc, NULL, NULL, :ID_OPERATION, 1, NULL, NULL, NULL, NULL, NULL);

		--Обновление временной таблицы
		update T_TEMP_TABLE TT
		set TT.INT_FIELD6 = :ID_OPERATION,
		TT.INT_FIELD7 = :ID_OFFSET_DEAL
		where TT.INT_FIELD1 = :TEMP_KEY and
		TT.INT_FIELD2 = :ID_NUMBER;

	end    

	--Реестр зачетов страховых платежей
	--Витрати. Одна поперация на сумму операции
	INSERT INTO f_dt_offset_deals (ID_OFFSET_DEAL, OD_DATE, OD_SUM, ID_CUSTOMER, ID_CF_TYPE, ID_DOC, ID_DOC_1C, ID_DOC_CLAIM, ID_OPERATION, ID_CL_TYPE, ID_PAYMENT, IS_FIXED, ID_PAY_DIRECTION, ID_REGRESS, CF_REPAYMENT)
	VALUES (gen_id(GEN_F_UP_DT_OFFSET_DEAL_ID, 1), :DATE_OPERATION, :sum_operation, :id_customer_wog, 138, :id_doc_wog, NULL, NULL, :ID_OPERATION, 2, NULL, NULL, NULL, NULL, 1);

	-- подписать операцию
	update f_dt_operations o
	set o.id_state_operation = 2 -- подписана
	where o.id_operation = :ID_OPERATION; 

end

end


/* --Проверка
select
--TT.INT_FIELD1 as TEMP_KEY,
TT.INT_FIELD2 as ID_NUMBER,
TT.INT_FIELD3 as ID_BLANK,
TT.INT_FIELD4 as id_customer,
TT.INT_FIELD5 as id_doc,
TT.INT_FIELD6 as ID_OPERATION,
TT.INT_FIELD7 as ID_OFFSET_DEAL,
TT.CURR_FIELD1 as INSURANCE_PAYMENT
from T_TEMP_TABLE TT
where TT.INT_FIELD1 = 4240
order by TT.INT_FIELD2  
/**/

