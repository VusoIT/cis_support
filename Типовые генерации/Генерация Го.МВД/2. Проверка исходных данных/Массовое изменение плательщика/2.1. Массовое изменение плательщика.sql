execute block
as

declare variable DATE_FROM tdate;
declare variable DATE_TO tdate;
declare variable CUSTOMER_FIO varchar(400);
declare variable CUSTOMER_I varchar(400);

begin

--Настройки
DATE_FROM = '01.06.2016';          --Дата начала периода генерации
DATE_TO = '30.06.2016';            --Дата конца периода генерации   
CUSTOMER_FIO = 'Петренко В.Л.';  --Ставим Любую фамилию и инициалы (БАНК ПОШТА)
CUSTOMER_I = 'И.В.';               --Ставим любые инициалы (ОДНА ФАМИЛИЯ)
--Настройки (Конец)

--БАНК ПОШТА
update F_DT_CASH_FLOW CA set CA.CF_CUSTOMER = :CUSTOMER_FIO --Ставим Любую фамилию и инициалы
where CA.ID_CASH_FLOW in (
select
cf.id_cash_flow
    from f_dt_payments p
      inner join f_dt_cash_flow cf
        on cf.id_cash_flow = p.id_cash_flow
    where cf.cf_date between :DATE_FROM and :DATE_TO  -- период
      and cf.cf_cl_type = 1                -- поступления
      and p.cf_type in (26, 123, 148)      -- статьи Ск (для открытого периода) или непр (для закрытого в КИС периода)
      and p.cf_division = 1497             -- подразделение Го.МВД
      and p.fact_sum in (10, 30, 40, 50, 60, 75, 80, 100, 140, 150, 160, 200, 240, 280, 300, 320, 340, 360, 380, 400)
        --120, 125, 170, 182, 245, 272, 350, 392, 420, 425, 450, 476, 480, 500, 600, 680, 686, 800, 980) -- дополнения по медицине
      and p.id_doc is null            -- нет привязки договора
      and p.id_operation is null
      --Критерии проверки
      and (
      --ключевые слова:
      upper(cf.cf_customer) like '%БАНК%'
          --or upper(cf.cf_customer) like '%ПОШТА%'
          or upper(cf.cf_customer) like '%ПДВ%'
          --or upper(cf.cf_customer) like '%ВІД%'
          
          --Коррекция
          or upper(cf.cf_customer) = upper('ц-1') --8846733
          
          )
          
          
  --Коррекция
           and upper(cf.cf_customer) <> 'ВІДВОВК СЕРГІЙ ВОЛОДИМИРОВИЧ'
           and upper(cf.cf_customer) <> 'ВІДВОЛОШЕНЮК СЕРГІЙ АНАТОЛІЙОВИЧ'
           and upper(cf.cf_customer) <> 'ВІДГАВРИШ ОЛЕКСАНДР СЕРГІЙОВИЧ'
           and upper(cf.cf_customer) <> 'ВІДКРИШТАЛЬ СЕРГІЙ ВІКТОРОВИЧ'
           and upper(cf.cf_customer) <> 'ВІДСЕМЕНЮК СВІТЛАНА ОЛЕКСАНДРІВНА'
           and upper(cf.cf_customer) <> 'ВІДТОНКОПІЙ ТЕТЯНА ЛЕОНІДІВНА'
           and upper(cf.cf_customer) <> 'ВІДЯНЧУК МИКОЛА ГЕННАДІЙОВИЧ'
  --Коррекция(конец)
          
) ;

--ОДНА ФАМИЛИЯ
update F_DT_CASH_FLOW CA set CA.CF_CUSTOMER = upper(left(trim(CA.CF_CUSTOMER), 1)) || lower(substring(trim(CA.CF_CUSTOMER) from 2)) || ' ' || :CUSTOMER_I
where CA.ID_CASH_FLOW in (
select
cf.id_cash_flow
    from f_dt_payments p
      inner join f_dt_cash_flow cf
        on cf.id_cash_flow = p.id_cash_flow
     where cf.cf_date between :DATE_FROM and :DATE_TO  -- период
      and cf.cf_cl_type = 1                -- поступления
      and p.cf_type in (26, 123, 148)      -- статьи Ск (для открытого периода) или непр (для закрытого в КИС периода)
      and p.cf_division = 1497             -- подразделение Го.МВД
      and p.fact_sum in (10, 30, 40, 50, 60, 75, 80, 100, 140, 150, 160, 200, 240, 280, 300, 320, 340, 360, 380, 400)
        --120, 125, 170, 182, 245, 272, 350, 392, 420, 425, 450, 476, 480, 500, 600, 680, 686, 800, 980) -- дополнения по медицине
      and p.id_doc is null            -- нет привязки договора
      and p.id_operation is null
      --Критерии проверки
      and (CHAR_LENGTH(trim(cf.cf_customer)) - CHAR_LENGTH(REPLACE(trim(cf.cf_customer), ' ', '')) = 0)
);

end 