/*
Генерация ВОГ
1_Заполнение_временной_таблицы
Мельников Т.В. 04.06.2016
/**/

execute block as
declare variable TEMP_KEY integer; --Ключ временной таблицы
declare variable QT_99 integer;  --Необходимое количество по 99 грн.
declare variable QT_199 integer; --Необходимое количество по 199 грн.
declare variable QT_499 integer; --Необходимое количество по 499 грн.
--Утилитарные переменные
declare variable I integer;

begin

  --Настройки
  TEMP_KEY = 4240; --Ключ временной таблицы
  QT_99    = XXXX; --Необходимое количество по 99 грн.
  QT_199   = XXX;   --Необходимое количество по 199 грн.
  QT_499   = XX;   --Необходимое количество по 499 грн.

  --Очистка временной таблицы по ключу
  delete from T_TEMP_TABLE TT where TT.INT_FIELD1 = :TEMP_KEY;

  I = 0;
  --Заполнение записями по 99 грн.
  while (I < QT_99) do
  begin
    insert into T_TEMP_TABLE (INT_FIELD1, INT_FIELD2, CURR_FIELD1)
    values (:TEMP_KEY, :I+1, 99);
    I = I + 1;
  end

  --Заполнение записями по 199 грн.
  while ((I - QT_99) < QT_199) do
  begin
    insert into T_TEMP_TABLE (INT_FIELD1, INT_FIELD2, CURR_FIELD1)
    values (:TEMP_KEY, :I+1, 199);
    I = I + 1;
  end

  --Заполнение записями по 499 грн.
  while (I - (QT_199 + QT_99) < QT_499) do
  begin
    insert into T_TEMP_TABLE (INT_FIELD1, INT_FIELD2, CURR_FIELD1)
    values (:TEMP_KEY, :I+1, 499);
    I = I + 1;
  end

end

/* --Проверка
select
--tt.int_field1 as TEMP_KEY,
TT.INT_FIELD2 as ID_NUMBER,
TT.CURR_FIELD1
from T_TEMP_TABLE TT
where TT.INT_FIELD1 = 4240
order by TT.INT_FIELD2  
/**/ 