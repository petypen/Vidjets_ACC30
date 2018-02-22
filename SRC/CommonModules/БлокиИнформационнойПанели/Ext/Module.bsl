﻿#Область ПрограммныйИнтерфейс

// Возвращает таблицу свойств предопределенных блоков
//
// Возвращаемое значени:
//   ТаблицаЗначений - описание полей см. в методе НоваяТаблицаБлоков()
//
&Вместо("ПредопределенныеБлоки")
Функция ВидБух_ПредопределенныеБлоки() Экспорт
	
	ТаблицаБлоков = НоваяТаблицаБлоков();
	
	ИспользуетсяРазделениеДанных = ТехнологияСервисаИнтеграцияСБСП.ДоступноИспользованиеРазделенныхДанных()
		И ТехнологияСервисаИнтеграцияСБСП.РазделениеВключено();
	
	// Монитор основных показателей
	Если ОстаткиДенежныхСредствДоступны() Тогда
		ДобавитьОстаткиДенежныхСредств(ТаблицаБлоков);
	КонецЕсли;
	
	Если ПокупателиДоступны() Тогда
		ДобавитьПокупатели(ТаблицаБлоков);
	КонецЕсли;
	
	Если ПоставщикиДоступны() Тогда
		ДобавитьПоставщики(ТаблицаБлоков);
	КонецЕсли;
	
	Если ПродажиДоступны() Тогда
		ДобавитьПродажи(ТаблицаБлоков);
	КонецЕсли;
	
	// ВИДЖЕТЫ ПОЛЬЗОВАТЕЛЯ
	Если ПОЛЬЗ0_Доступен() Тогда
		ДобавитьПОЛЬЗ0(ТаблицаБлоков);
	КонецЕсли;

	Если ПОЛЬЗ1_Доступен() Тогда
		ДобавитьПОЛЬЗ1(ТаблицаБлоков);
	КонецЕсли;
	
	Если ПОЛЬЗ2_Доступен() Тогда
		ДобавитьПОЛЬЗ2(ТаблицаБлоков);
	КонецЕсли;
	
	// Список задач
	Если ЗадачиДоступны() Тогда
		ДобавитьЗадачи(ТаблицаБлоков);
	КонецЕсли;
	
	// 1С-Отчетность
	Если ОтчетностьДоступна() Тогда
		ДобавитьОтчетность(ТаблицаБлоков);
	КонецЕсли;
	
	// БИП
	Если ОбработкаНовостейПовтИсп.РазрешенаРаботаСНовостямиТекущемуПользователю() Тогда
		ДобавитьНовости(ТаблицаБлоков);
	КонецЕсли;
	
	Если МетодическаяПоддержкаДоступна() Тогда
		ДобавитьМетодическаяПоддержка(ТаблицаБлоков);
	КонецЕсли;
	
	Если ИспользуетсяРазделениеДанных Тогда
		ДобавитьПоддержкаСервиса(ТаблицаБлоков);
	КонецЕсли;
	
	Если ПолучитьФункциональнуюОпцию("ИспользоватьСервисСПАРКРиски")
		И СПАРКРиски.ИспользованиеРазрешено() Тогда
		Добавить1СПАРКРиски(ТаблицаБлоков);
	КонецЕсли;
	
	Возврат ТаблицаБлоков;
	
КонецФункции

#КонецОбласти

#Область ДанныеИнформационнойПанели

#Область ПОЛЬЗ0

Функция ПОЛЬЗ0_Доступен()
	
	Возврат Истина;
	
КонецФункции

Процедура ДобавитьПОЛЬЗ0(ТаблицаБлоков)
	
	Добавить(ТаблицаБлоков,
		БлокиИнформационнойПанелиКлиентСервер.ИмяБлокаПОЛЬЗ0(),
		БлокиИнформационнойПанелиКлиентСервер.ТекстЗаголовкаПОЛЬЗ0(),
		"БлокиИнформационнойПанели.ПОЛЬЗ0",
		"БлокиИнформационнойПанели.ОбновитьПОЛЬЗ0",
		СвойстваПОЛЬЗ0());
	
КонецПроцедуры
	
// Функция - Свойства информационного блока
//	Поля блока, перечисленные в методе должны совпадать с реквизитами формы
// 
// Возвращаемое значение:
//  Строка - поля блока через ","
//
Функция СвойстваПОЛЬЗ0()
	Перем сСвойства;
	
	сСвойства = "ПОЛЬЗ0_Заголовок, ПОЛЬЗ0_ДатаКурса,
	| ПОЛЬЗ0_Валюта1, ПОЛЬЗ0_Валюта2, ПОЛЬЗ0_Валюта3,
	| ПОЛЬЗ0_Курс1, ПОЛЬЗ0_Курс2, ПОЛЬЗ0_Курс3,";
	
	Возврат сСвойства;
КонецФункции

// Обновляет данные блока
//
// Параметры:
//   Параметры - Структура
//     * Организация - СправочникСсылка.Организации - отбор по организации
//     * ПоказыватьСравнениеСПрошлымГодом - Булево - необходимость сравнения с показателями прошлого года
//
Процедура ОбновитьПОЛЬЗ0(Параметры) Экспорт
	
	// код метода
	
КонецПроцедуры

// Помещает во временное хранилище данные блока
//
// Параметры:
//   Параметры - Структура
//     * АдресХранилища - Строка - адрес хранилища результата
//     * Организация - СправочникСсылка.Организации - отбор по организации
//     * ВариантОкругления - Число - 1 - округлять до целых рублей, 1000 - до тысяч 
//     * ПоказыватьСравнениеСПрошлымГодом - Булево - необходимость сравнения с показателями прошлого года
//     * Инициализация - Истина - заполнить только статическими данными
//
Процедура ПОЛЬЗ0(Параметры) Экспорт
	Перем стДанныеБлока, мКурсыВалют, фсВалюта, фсКурс, чИндекс, Шрифт, ЦветТекста, дПериод, фсДатаКурса;	
	
	Если Параметры.Инициализация Тогда
		Возврат;
	КонецЕсли;
	
	мКурсыВалют = ВидБух_ПОЛЬЗ_Сервер.КурсыВалютКакМассив();
	Если НЕ(ТипЗнч(мКурсыВалют) = Тип("Массив") и мКурсыВалют.Количество() > 0) Тогда
		Возврат;
	КонецЕсли;
	
	Шрифт = ШрифтыСтиля.ШрифтТекстаИнформационнойПанели;
	ЦветТекста = ЦветаСтиля.ЦветТекстаИнформационнойПанели;

	стДанныеБлока = Новый Структура();
	стДанныеБлока.Вставить("ПОЛЬЗ0_Заголовок", ЗаголовокБлока(БлокиИнформационнойПанелиКлиентСервер.ТекстЗаголовкаПОЛЬЗ0()));
	дПериод = мКурсыВалют[мКурсыВалют.Количество()-1].дПериод;
	фсДатаКурса = Новый ФорматированнаяСтрока("Курс на " + Формат(дПериод,"ДФ=dd.MM.yy"));
	стДанныеБлока.Вставить("ПОЛЬЗ0_ДатаКурса", фсДатаКурса);
	
	Для чИндекс = 1 По мКурсыВалют.Количество() Цикл
		фсВалюта = Новый ФорматированнаяСтрока(ФлагСтраны(мКурсыВалют[чИндекс - 1].сВалюта), ВалютаНаименование(мКурсыВалют[чИндекс - 1].сВалюта));
		стДанныеБлока.Вставить(СтрШаблон("ПОЛЬЗ0_Валюта%1", Строка(чИндекс)), фсВалюта);
		фсКурс = Новый ФорматированнаяСтрока(Формат(мКурсыВалют[чИндекс - 1].чКурс, "ЧДЦ=4; ЧН=0"), Шрифт, ЦветТекста);
		стДанныеБлока.Вставить(СтрШаблон("ПОЛЬЗ0_Курс%1", Строка(чИндекс)), фсКурс);		
	КонецЦикла;	
	
	ПоместитьВоВременноеХранилище(стДанныеБлока, Параметры.АдресХранилища);
	
КонецПроцедуры

Функция ВалютаНаименование(Знач сВалюта)
	Перем фсВалюта, _сВалюта;
	
	фсВалюта = "";
	Если НЕ(ТипЗнч(сВалюта) = Тип("Строка") И НЕ ПустаяСтрока(сВалюта)) Тогда
		Возврат фсВалюта;
	КонецЕсли;
	
	Шрифт = ШрифтыСтиля.ШрифтТекстаИнформационнойПанели;
	ЦветТекста = ЦветаСтиля.ЦветТекстаИнформационнойПанели;
    _сВалюта = СтрСоединить(СтрРазделить(сВалюта, ".", Истина),"");
	фсВалюта = Новый ФорматированнаяСтрока(ВРег(СокрЛП(_сВалюта)), Шрифт, ЦветТекста);

	Возврат фсВалюта;
КонецФункции

Функция ФлагСтраны(Знач сВалюта)
	Перем фсФлаг, оКартинка, _сВалюта;
	
	фсФлаг = "";
	Если НЕ(ТипЗнч(сВалюта) = Тип("Строка") И НЕ ПустаяСтрока(сВалюта)) Тогда
		Возврат фсФлаг;
	КонецЕсли;
	
	_сВалюта = ВРег(СокрЛП(сВалюта));
	Если СтрНайти(_сВалюта, "РУБ") > 0 Тогда
		фсФлаг = Новый ФорматированнаяСтрока(БиблиотекаКартинок.ВидБух_ФлагРоссия);
	ИначеЕсли СтрНайти(_сВалюта, "USD") > 0 Тогда 
		фсФлаг = Новый ФорматированнаяСтрока(БиблиотекаКартинок.ВидБух_ФлагСША);
	ИначеЕсли СтрНайти(_сВалюта, "EUR") > 0 Тогда
		фсФлаг = Новый ФорматированнаяСтрока(БиблиотекаКартинок.ВидБух_ФлагЕС);
	Иначе
		фсФлаг = "";
	КонецЕсли;
	
	Если ТипЗнч(фсФлаг) = Тип("ФорматированнаяСтрока") Тогда
		фсФлаг = Новый ФорматированнаяСтрока(фсФлаг, " ");
	КонецЕсли;
	
	Возврат фсФлаг;	
КонецФункции

#КонецОбласти

#Область ПОЛЬЗ1

Функция ПОЛЬЗ1_Доступен()
	
	Возврат Истина;
	
КонецФункции

Процедура ДобавитьПОЛЬЗ1(ТаблицаБлоков)
	
	Добавить(ТаблицаБлоков,
		БлокиИнформационнойПанелиКлиентСервер.ИмяБлокаПОЛЬЗ1(),
		БлокиИнформационнойПанелиКлиентСервер.ТекстЗаголовкаПОЛЬЗ1(),
		"БлокиИнформационнойПанели.ПОЛЬЗ1",
		"БлокиИнформационнойПанели.ОбновитьПОЛЬЗ1",
		СвойстваПОЛЬЗ1());
	
КонецПроцедуры
	
Функция СвойстваПОЛЬЗ1()
	Перем сСвойства;
	
	сСвойства = "ПОЛЬЗ1_Заголовок, ПОЛЬЗ1_Данные0";
	
	Возврат сСвойства;
КонецФункции

// Обновляет данные блока
//
// Параметры:
//   Параметры - Структура
//     * Организация - СправочникСсылка.Организации - отбор по организации
//     * ПоказыватьСравнениеСПрошлымГодом - Булево - необходимость сравнения с показателями прошлого года
//
Процедура ОбновитьПОЛЬЗ1(Параметры) Экспорт
	
	// код метода
	
КонецПроцедуры

// Помещает во временное хранилище данные блока
//
// Параметры:
//   Параметры - Структура
//     * АдресХранилища - Строка - адрес хранилища результата
//     * Организация - СправочникСсылка.Организации - отбор по организации
//     * ВариантОкругления - Число - 1 - округлять до целых рублей, 1000 - до тысяч 
//     * ПоказыватьСравнениеСПрошлымГодом - Булево - необходимость сравнения с показателями прошлого года
//     * Инициализация - Истина - заполнить только статическими данными
//
Процедура ПОЛЬЗ1(Параметры) Экспорт
	
	Если Параметры.Инициализация Тогда
		Результат = Новый Структура();
		Результат.Вставить("ПОЛЬЗ1_Заголовок",
			ЗаголовокБлока(БлокиИнформационнойПанелиКлиентСервер.ТекстЗаголовкаПОЛЬЗ1()));
		ПоместитьВоВременноеХранилище(Результат, Параметры.АдресХранилища);
		Возврат;
	КонецЕсли;
	
	Результат = Новый Структура();
	Результат.Вставить("ПОЛЬЗ1_Заголовок",
		ЗаголовокБлока(БлокиИнформационнойПанелиКлиентСервер.ТекстЗаголовкаПОЛЬЗ1()));
	Результат.Вставить("ПОЛЬЗ1_Данные0","Информация виджета пользователя");
	
	ПоместитьВоВременноеХранилище(Результат, Параметры.АдресХранилища);
	
КонецПроцедуры

#КонецОбласти

#Область ПОЛЬЗ2

Функция ПОЛЬЗ2_Доступен()
	
	Возврат Ложь;
	
КонецФункции

Процедура ДобавитьПОЛЬЗ2(ТаблицаБлоков)
	
	Добавить(ТаблицаБлоков,
		БлокиИнформационнойПанелиКлиентСервер.ИмяБлокаПОЛЬЗ2(),
		БлокиИнформационнойПанелиКлиентСервер.ТекстЗаголовкаПОЛЬЗ2(),
		"БлокиИнформационнойПанели.ПОЛЬЗ2",
		"БлокиИнформационнойПанели.ОбновитьПОЛЬЗ2",
		СвойстваПОЛЬЗ2());
	
КонецПроцедуры

Функция СвойстваПОЛЬЗ2()
	Перем сСвойства;
	
	сСвойства = "ПОЛЬЗ2_Заголовок, ПОЛЬЗ2_Данные0";
	
	Возврат сСвойства;
КонецФункции

// Обновляет данные блока
//
// Параметры:
//   Параметры - Структура
//     * Организация - СправочникСсылка.Организации - отбор по организации
//     * ПоказыватьСравнениеСПрошлымГодом - Булево - необходимость сравнения с показателями прошлого года
//
Процедура ОбновитьПОЛЬЗ2(Параметры) Экспорт
	
	// код метода
	
КонецПроцедуры

// Помещает во временное хранилище данные блока
//
// Параметры:
//   Параметры - Структура
//     * АдресХранилища - Строка - адрес хранилища результата
//     * Организация - СправочникСсылка.Организации - отбор по организации
//     * ВариантОкругления - Число - 1 - округлять до целых рублей, 1000 - до тысяч 
//     * ПоказыватьСравнениеСПрошлымГодом - Булево - необходимость сравнения с показателями прошлого года
//     * Инициализация - Истина - заполнить только статическими данными
//
Процедура ПОЛЬЗ2(Параметры) Экспорт
	
	Если Параметры.Инициализация Тогда
		Результат = Новый Структура();
		Результат.Вставить("ПОЛЬЗ2_Заголовок",
			ЗаголовокБлока(БлокиИнформационнойПанелиКлиентСервер.ТекстЗаголовкаПОЛЬЗ2()));
		ПоместитьВоВременноеХранилище(Результат, Параметры.АдресХранилища);
		Возврат;
	КонецЕсли;
	
	Результат = Новый Структура();
	Результат.Вставить("ПОЛЬЗ2_Заголовок",
		ЗаголовокБлока(БлокиИнформационнойПанелиКлиентСервер.ТекстЗаголовкаПОЛЬЗ2()));
	Результат.Вставить("ПОЛЬЗ2_Данные0","Информация виджета пользователя");
	
	ПоместитьВоВременноеХранилище(Результат, Параметры.АдресХранилища);
	
КонецПроцедуры

#КонецОбласти

#КонецОбласти
