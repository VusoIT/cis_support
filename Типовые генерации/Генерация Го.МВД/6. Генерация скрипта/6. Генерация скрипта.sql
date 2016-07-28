--http://portal.vuso.ua/issues/127289
--Генерация Го.МВД. Описание алгоритма

--Генерация скрипта, осуществляется вызовом процедуры Вызов процедуры - xd_generate_full

select * from xd_generate_full (null, 999)

--в качестве результата вернёт текст скрипта. Его необходимо сохранить в текстовый файл, а потом выполнить в Редакторе скриптов IBExpert.


--Внимание! Процедура старая, поэтому часть настроек находится непосредственно в теле процедуры. Более того, так как это процедура, а не скрипт, при каждом релизе Некстеп накатывает свою версию процедуры, поэтому наши изменения теряются.

--Перед каждым запуском процедуры необходимо внести изменения в её текст:
--Архивные номера
--Даты выборки
--Номера бланков
--Ключ временной таблицы


--Пример:

  /* инициализация переменных */
/*
  -- Архивный том
  arch_num_min_id = 447;--перед новой генерацией, изменить на первый номер тома
  arch_num_max_id = 455;--перед новой генерацией, изменить на последний номер тома
  -- номер в архиве
  arch_tom_num_id = 1;
  -- номера договоров
  doc_num_min = 2609363;
  doc_num_max = 2617431;
  -- даты выборки
  pay_date_min = cast('01.01.2016' as tdate);
  pay_date_max = cast('31.03.2016' as tdate);
  -- операция для отбора платедей (87552 по-умолчанию, иногда 87555)
  id_operation = 87552;
*/
  /* установка базовых значений */
/*  
  arch_num_id = :arch_num_min_id;
  if (:id_temp_key is null) then id_temp_key = 999;
*/ 







--Это не делать, старое!!!
/*
Далее, находим:
        --------------------------------------------------------------------------
        --- заполнение временной таблицы
        result =  result ||
                  'update t_temp_table set STR_FIELD1 = '''||:reg_num_str||''','||
                    'STR_FIELD4='''||:arch_num_str||''','||
                    'INT_FIELD4=(select d.id_doc '||
                      'from d_dt_document d inner join t_temp_table tt '||
                        'on d.reg_num starting with tt.str_field1 || ''-'' '||
                          'and d.id_state=3 '||
                          'and d.id_doc_source=3 '||
                      'where tt.int_field1='||:id_temp_key||
                        ' and tt.int_field2='||:id_pay||')'||
                  ' where INT_FIELD1=' || :id_temp_key ||
                      ' and INT_FIELD2=' ||:id_pay||';
        ';

Заменяем на строке 320 : 'and d.id_state=3 '||    на    'and d.id_state in (1, 3) '||

        --------------------------------------------------------------------------
        --- заполнение временной таблицы
        result =  result ||
                  'update t_temp_table set STR_FIELD1 = '''||:reg_num_str||''','||
                    'STR_FIELD4='''||:arch_num_str||''','||
                    'INT_FIELD4=(select d.id_doc '||
                      'from d_dt_document d inner join t_temp_table tt '||
                        'on d.reg_num starting with tt.str_field1 || ''-'' '||
                          'and d.id_state in (1, 3) '||
                          'and d.id_doc_source=3 '||
                      'where tt.int_field1='||:id_temp_key||
                        ' and tt.int_field2='||:id_pay||')'||
                  ' where INT_FIELD1=' || :id_temp_key ||
                      ' and INT_FIELD2=' ||:id_pay||';
        ';		
		
*/		