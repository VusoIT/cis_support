/*
Генерация ВОГ
6_Обновить_другие даты
Мельников Т.В. 10.07.2016

Инструкция 1
Скрипт предназначен для коррекции "других дат", что-бы они соответствовали дате операции.
Например: если операция 30.06.2016 г., то и "другие даты" договоров должны быть за 6-месяц.
Не должно получиться так, что договор сгенерирован за 01.01.2015 г., операция - 30.06.2016 г., а "другие даты" у договора - 01.07.2016 г.

/**/

execute block
as
declare variable ID_DOC TINTEGER;
begin

Читать инструкцию 1 !!!

  for select TT.INT_FIELD5 as ID_DOC
      from T_TEMP_TABLE TT
      where TT.INT_FIELD1 = 4240
      order by TT.INT_FIELD2
      into :ID_DOC
  do
  begin
    update D_DT_DOCUMENT DD
    set DD.IS_OTHER_INNURE = 1,
        DD.OTHER_DATE_DOC = '01.06.2016',
        DD.OTHER_INURE_DATE_DOC = '01.06.2016',
        DD.OTHER_END_DATE_DOC = '01.06.2017'
    where DD.ID_DOC = :ID_DOC;
  end
end