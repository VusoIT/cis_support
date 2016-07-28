--http://portal.vuso.ua/issues/127289
--Генерация Го.МВД. Описание алгоритма

execute block
as
  declare variable id_payment tinteger;
begin
  for
    select p.id_payment
    from f_dt_payments p
      inner join f_dt_cash_flow cf
        on cf.id_cash_flow = p.id_cash_flow
    where cf.cf_date between date '01.06.2016' and date '30.06.2016'
      and cf.cf_cl_type = 1                -- поступления
      and p.cf_type in (26, 123, 148)      -- статьи Ск (для открытого периода) или непр (для закрытого в КИС периода)
      and p.cf_division = 1497             -- подразделение Го.МВД
      and p.fact_sum  in (10, 30, 40, 50, 60, 75, 80, 100, 140, 150, 160, 200, 240, 280, 300, 320, 340, 360, 380, 400)
        --120, 125, 170, 182, 245, 272, 350, 392, 420, 425, 450, 476, 480, 500, 600, 680, 686, 800, 980) -- дополнения по медицине
      and p.id_doc is null            -- нет привязки договора
      and (p.id_operation is null or p.id_operation = 87552)
    into :id_payment
  do
    update f_dt_payments p
    set p.id_operation = 87552 /*,
      p.cf_type = 148,
      p.id_bu_fu = 48 /**/
    where p.id_payment = :id_payment;
end


/*
--Посмотреть, сколько помечено
select p.id_operation, count(*), sum (p.fact_sum)
from f_dt_payments p
where p.id_operation in (87552)--, 87554, 87555)
group by 1
/**/

/*
--Посмотреть, сколько помечено (Мой вариант)
select p.id_operation, count(*), sum (p.fact_sum)
from f_dt_payments p
join f_dt_cash_flow cf on p.id_cash_flow = cf.id_cash_flow
where p.id_operation in (87552)--, 87554, 87555)
--and cf.cf_date between date '01.05.2016' and date '31.05.2016'
group by 1

/**/