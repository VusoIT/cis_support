--http://portal.vuso.ua/issues/127289
--Генерация Го.МВД. Описание алгоритма

--1) п.2. Проверка исходных данных

select
p.id_payment,
cf.id_cash_flow,
 cf.cf_customer
    from f_dt_payments p
      inner join f_dt_cash_flow cf
        on cf.id_cash_flow = p.id_cash_flow
    where cf.cf_date between date '01.05.2016' and date '31.05.2016'  -- период
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
          or upper(cf.cf_customer) like '%ПОШТА%'
          or upper(cf.cf_customer) like '%ПДВ%'
          or upper(cf.cf_customer) like '%ВІД%'

          --Коррекция
          --or upper(cf.cf_customer) = upper('ц-1')

      --контрагенты, где нет пробела в середине слова:
          or CHAR_LENGTH(trim(cf.cf_customer)) - CHAR_LENGTH(REPLACE(trim(cf.cf_customer), ' ', '')) = 0
           )

   --Коррекция
      /*
           and upper(cf.cf_customer) <> 'ВІДВОЛОШЕНЮК СЕРГІЙ АНАТОЛІЙОВИЧ'
           and upper(cf.cf_customer) <> 'ВІДГАВРИШ ОЛЕКСАНДР СЕРГІЙОВИЧ'
           and upper(cf.cf_customer) <> 'ВІДКРИШТАЛЬ СЕРГІЙ ВІКТОРОВИЧ'
           and upper(cf.cf_customer) <> 'ВІДСЕМЕНЮК СВІТЛАНА ОЛЕКСАНДРІВНА'
           and upper(cf.cf_customer) <> 'ВІДТОНКОПІЙ ТЕТЯНА ЛЕОНІДІВНА'
           and upper(cf.cf_customer) <> 'ВІДЯНЧУК МИКОЛА ГЕННАДІЙОВИЧ'
           /**/
  --Коррекция(конец)




/*--Правим запросом
select cf.id_cash_flow, cf.cf_customer from f_dt_cash_flow cf
where cf.id_cash_flow in(
 4454176
)





  /**/