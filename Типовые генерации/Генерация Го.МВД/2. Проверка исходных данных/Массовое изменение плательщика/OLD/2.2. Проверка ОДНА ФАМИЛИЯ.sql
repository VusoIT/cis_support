--1) п.2. Проверка исходных данных

--1. Получаем id_cash_flow
select
cf.id_cash_flow
 --Имя комментируем, для получения ID - шек
, cf.cf_customer
/**/
    from f_dt_payments p
      inner join f_dt_cash_flow cf
        on cf.id_cash_flow = p.id_cash_flow
    where cf.cf_date between date '01.01.2016' and date '30.04.2016'  -- период
      and cf.cf_cl_type = 1                -- поступления
      and p.cf_type in (26, 123, 148)      -- статьи Ск (для открытого периода) или непр (для закрытого в КИС периода)
      and p.cf_division = 1497             -- подразделение Го.МВД
      and p.fact_sum in (10, 30, 40, 50, 60, 75, 80, 100, 140, 150, 160, 200, 240, 280, 300, 320, 340, 360, 380, 400)
        --120, 125, 170, 182, 245, 272, 350, 392, 420, 425, 450, 476, 480, 500, 600, 680, 686, 800, 980) -- дополнения по медицине
      and p.id_doc is null            -- нет привязки договора
      and p.id_operation is null
      --Критерии проверки
      and (CHAR_LENGTH(trim(cf.cf_customer)) - CHAR_LENGTH(REPLACE(trim(cf.cf_customer), ' ', '')) = 0)
	  

/*

--2. Смотрим, а потом правим

select CA.CF_CUSTOMER from F_DT_CASH_FLOW CA

--update F_DT_CASH_FLOW CA set CA.CF_CUSTOMER = upper(left(trim(CA.CF_CUSTOMER), 1)) || lower(substring(trim(CA.CF_CUSTOMER) from 2)) || ' Д.И.' --Ставим любые инициалы. В дальнейшем, можно усовершенствовать и сделать по рендому...

where CA.ID_CASH_FLOW in (

4228237,
4290203,
4295175,
4295296,
4295459,
4295516,
4304542,
4354575,
4354592,
4354594,
4354602,
4354608

)    

/**/
