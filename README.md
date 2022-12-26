# ITC Candidates Accounting - ITC_CandidAcc.

## Описание предметной области и проблематики
Дважды в год в АНО ДТ "Красноярский кванториум" проводится отбор детей на обучение по программам дополнительного образования в области IT. Процедура отбора происходит в несколько этапов и растянута, фактически, на весь календарный год.
В течении года происходит сбор заявок на обучение. Желающие попасть на обучение оставляют заявки по всем возможным каналам связи, преимуществом из которых пользуется google-форма на сайте проекта. Форма записывает результаты в csv-файл, собирая как можно больше данных о кандидате: ФИО, год рождения, образовательное учреждение и класс, группу здоровья, информацию об официальных представителях, имеющихся навыках и желаемых направлениях обучения.
Ближе к учебному году происходит ручной проход по файлу с кандидатами, с целью уточнить данные, перечисленные в форме, после проверки остаются только те, кто ответил на обращение. С прошедшими формируется график собеседований, так как желающих поступить может быть гораздо больше, а также, чтобы определить, действивтельно ли кандидат осилит выбранное направление.
После завершения собеседований подводятся итоги, формируются списки учащихся: учащихся, в зависимости от уровня навыков, терриотриальной доступности и желаемого времени посещения распределяют по группам. Участники групп уведомляются о зачислении.
Группы распределяются между наставниками, группам присваиваются шифры. После этого начинается учебный год.
В течении года преподаватели сообщают обратную связь по учащимся. Анализ обратной связи позволяет определить качество разработанной образовательной программы, а также определить, оставлять ли учащемуся возможность в будущем повторно поступить на обучение - один кандидат может посещать не более двух групп одновременно и может сколько угодно раз пытаться зачислиться на обучение в периоды набора.


## Проблема и обоснование решения
### Описание проблемы
Весь процесс проведения кандидата от заявки до зачисления (и последующего отчисления в связи с окончанием курса) проводится вручную, с использованием минимальных средств автоматизации труда (таблицы Excel, файлы csv, электронные списки, бумажные носители).
В подобном виде информация подвержена искажениям и повреждениям в ходе обработки и переноса, подсчёт и ведение статистики крайне затруднительны, поиск отдельно взятого кандидата и его полная история хранятся, зачастую в недокументированном виде либо на нескольких бумажных носителях.

### Обоснование решения
Для решения данной проблемы решено разработать базу данных (БД) для хранения сведений о части образовательного процесса, касающегося непосредственно учащегося на этапах, начиная с "Кандидат на зачисление" и закачнивая "Зачисленный учащийся".
Преимущества БД:
* Структурированность данных - данные разделены на совокупность связанных сущностей, что позволяет разделить их на ключевые и зависимые;
* Упорядоченность данных - данные хранятся в определённом порядке и легко поддаются сортировке;
* Возможность производить операции выборки - механизмы БД позволяют гибко выбирать произвольные данные об учащихся не пускаясь в поиски по разрозненным файлам;
* Возможность вести статистику - язык запросов БД позволяет выбирать данные таким образом, чтобы представлять их как статистическую выборку, что более доступно описывает происходящий процесс;
* Возможность удобного многопользовательского доступа для чтения;
* Возможность создания резервных копий данных механизмами БД;
* В зависимости от типа БД - возможность контроля пользовательских операций над данными в БД.


## Проектирование
### Основные данные
В предметной области существуют следующие объекты: "кандидат", "наставник", "группа", - взаимодействие между этими объектами описывает процесс следования кандидата от этапа подачи заявки к этапу получения сертификата о завершении обучения. 
"Кандидат" - сведения о желающем поступить на обучения, полученные из формы регистрации.
"Наставник" - сведения о преподавателе, ведущем одно или несколько направлений обучения, а также проводящем собеседования для набора в учебную группу.
"Группа" - учебная группа, в которой даются занятия в рамках одного направления обучения.
В ходе процесса экземпляр объекта "кандидат" претерпевает изменения, переходя из первичного состояния в состояние отбора (претендента), а затем, при успешном прохождении отбора - в учащегося группы: "кандидат" -> "претендент" -> "учащийся".
Экземпляры объекта "наставник" не претерпевают изменений, лишь меняются их связи с претендентами и учащимися на различных этапах.
Экземпляры объекта "группа" имеют время жизни в течении половины либо полного учебного года, впоследствии сохраняются как архивы.

### Дополнительные и служебные данные
Для детализации процесса, происходящего в предметной области, перечисленных объектов недостаточно - неясно, как связаны между собой перечисленные объекты и как "кандидат" проходит стадии преобразований в "учащийся". Для дальнейшего проектирования необходимо составить диаграмму потоков данных (scheme_1a, scheme_1b).

На схеме представлен поток данных из внешнего источника в конечный набор данных "список учащихся". Как видно, модели реального процесса присутствуют промежуточные накопители: Список кандидатов, Список претендентов, Список учащихся. Также на схеме присутствуют дополнительные объекты: Внешний источник (подразумевается сеть Интернет), Администратор. Объект "Учебные группы" - есть объект "группа".
"Списки" представляют собой накопители, содержащую информацию о кандидатах. Информация между накопителями несильно различается: сведения в них, зачастую, практически идентичны.
Объект "Администратор" занимается координацией и диспетчеризацией кандидатов: уточнение желания поступления, подбор даты и времени собеседования, а также определение в группу.

### Описание объектов данных - логический уровень
#### Кандидат
В заявке и в списке кандидатов содержатся сведения, описывающие человека возраста 7-18 лет. Перечислены ФИО, пол, дата рождения, образовательное учреждение основного образования, класс/курс обучения,  контактные данные, документы, удостоверяющие личность, желаемые направления, бытовые и медицинские значимые особенности. Также представлены ФИО и контактные данные законных представителей, если имеются.
При пререводе Кандидата в Претендента в объёме данных ничего не изменяется.
При переводе Претендента в Учащегося дополнительно появляется значение группы, в которую зачислен Учащийся. Один претендент может быть учащимся не более чем в двух группах одновременно. Один претендент в разные периоды обучения (разные наборы) может быть учащимся.

#### Наставник
Наставник выполняет роль собеседующего и преподавателя в разные периоды времени, но в обеих ролях набор значений идентичен: ФИО, дата рождения, контактные данные, образование, преподаваемые дисциплины.

#### Учебная группа
Представляет собой множество Учащихся, посещающих занятия в установленное время, в установленном месте, по заданному предмету, поэтому в данных группы содержатся следующие атрибуты: 
* Сезон набора - когда была сформирована группа;
* Предмет - по какому предмету собрана группа;
* Шифр группы - своего рода уникальный идентификатор группы в рамках всей деятельности площадки.


Было определено ранее, что основных объектов недостаточно и необходимо ввести дополнительные.

#### Объект "Собеседование"
Процесс преобразования Претендента в Учащегося, в экземпляре которого должны быть следующие данные: дата проведения, собеседуемый, собеседующий, явка, результат собеседования, комментарий.


Визуальное представление объектов изложено на схеме (scheme_2a).

#### Преобразование данных.

В текущием виде объектами данных пользоваться затруднительно, слишком много переходов от объекта к объекту и слишком много служебных значений, которые нужно где-то хранить. Поэтому проведём реструктуризацию данных для повышения эффективности обработки. 
Начнём с таблицы кандидатов. 
Информация о законных представителях кандидата не нужна 90% времени, поэтому её можно вынести в отдельный объект-справочник "Законный представитель" и ссылаться на неё из объекта Кандидат. Желаемые направления могут изменятья каждый набор, искать запись в таблице, изменять там значения и сохранять по новой может и не сильно дороже, чем создавать новые экземпляры в объекте "Желаемые направления", но для статистки формирования Кандидата в мире ИТ это может быть полезно. Документы кандидата тоже имеют преходящий (каких-то ещё нет, какие-то уже неактуальны) характер и их можно хранить во внешнем объекте с ссылкой на кандидата. Образовательное учреждение тоже можно вынести в отдельный объект, сформировав справочник с информацией об учреждении.
К этим объектам будут также сформированы связи: Кандидат:Представитель - М:О, Кандидат:Направления - О:М, Кандидат:Документ - О:М, Кандидат:Образовательное - М:О. 
Так как Учащийся и Кандидат - разные сущности, и Кандидат не состоит в Учебной группе, необходимо добавить объект Учащийся, являющийся результатом успешно пройденного собеседования кандидатом.
Один Кандидат может быть множеством учащихся, один учащийся является результатом одного собеседования, О:М, О:О соответственно. К одной группе относится множество учащихся: О:М.
Сведения, содержащиеся в учебной группе не позволяют объединять группы по предметам и направлениям обучения, в связи с этим необходимо добавить два объекта-справочника: направления обучения, предметы обучения. Направление:Предмет - О:М, Предмет:Группа - О:М.
Теперь осталось связать воедино Наставника, учащегося и группу - для этого создадим объект "Занятие", сообщающий о том, какой наставник, в какое время у какой группы будет вести занятие и в какой аудитории. Отношения занятия к учебным группам, аудиториям и наставникам - везде М:О.
(scheme_2b).


### Описание данных - физический уровень
Физическая схема данных более подробная чем логическая. Сначала будут описаны справочники, затем прочие объекты.
Атрибут id в описании всех отношений будет опущен, так как описывает уникальный номер экземпляра отношения.

#### Types
Перечисление типов (домен типов?) всех объектов с ограниченным диапазоном значений.
* group_id - ссылка на категорию типов;
* name - название типа.

#### Type_groups
Группировка типов по категориям для последующей обработки программной логикой.
* name - имя группы;

#### Statuses
Возможные состояния объектов, использующих состояния.
* group_id - ссылка на категорию статусов;
* name - название статуса;

#### Status_groups
Группировка состояний по категориям для последующей обработки программной логикой.
* name - имя группы;

#### Days_of_week
Словарь перечисления дней недели.
* day_name - название дня недели;

#### Districts
Районы проживания кандидатов, необходимо для подсчёта статистики кандидатов и учащихся по районам.
* name - название района;

#### Educational_establishments
Учебные заведения "основного" образования.
* type_id - ссылка на тип заведения;
* name - Название заведения;
* address - Адрес заведения;

#### Study_directions
Направления, на базе которых готовятся образовательные программы.
* name - наименование направления;

#### Programs
Образовательные программы, по которым производится обучение учащихся в рамках курса.
* name - наименование образовательной программы;
* type_id - тип образовательной программы (годична, полугодичная);
* direction_id - ссылка на направление, по которому подготовлена программа;

#### Parents
Родители, опекуны, или законные представители кандидата иного рода. Так как кандидатам, зачастую, нет 18 лет, то все соглашения и договора заключаются с законными представителями.
* fio - ФИО;
* phone_1 - контактный телефон основной;
* phone_2 - контактный телефон дополнительный;
* email - адрес электронной почты;

#### Candidates
Описание кандидатов, подавших заявку на обучение.
* fio - ФИО;
* sex - пол;
* birthdate - дата рождения;
* phone - контактный телефон;
* email - адрес электронной почты;
* school_id - ссылка на образовательное учреждение основного образования;
* grade_group - класс или курс в образовательном учреждении, необходимо для подсчёта статистики в разрезе школьных классов или курсов техникумов\ВУЗов;
* district_id - ссылка на район проживания кандидата;
* difficult_life_situation - имеет ли кандидат условия "тяжёлой жизненной ситуации";
* disability - имеет ли кандидат группу инвалидности;
* is_orphan - является ли кандидат сиротой или опекаемым;
* health_limitations - имеется ли у кандидата группа ОВЗ;
* parent_1_id - ссылка на законного представителя;
* parent_2_id - ссылка на законного представителя;

#### Documents
Документы, идентифицирующие личность кандидата. Это может быть свидетельство о рождении, паспорт, СНИЛС или какой-либо иной документ, устанавливающий и подтверждающий личность. Конкретно СНИЛС необходим для связи со внешними сервисами.
* type_id - ссылка на тип документа;
* owner_id - ссылка на владельца документа;
* series - серия документа, при наличии;
* number - номер документа;

#### Preferred_subjects
Перечень предметов, предпочитаемых кандидатом. Может содержать до трёх предметов, приоритет которых выставлен в порядке убывания. На схеме данных связи не обозначены для исключения перегрузки картины.
* candidate_id - ссылка на кандидата;
* subject_1_id - ссылка на программу;
* subject_2_id - ссылка на программу;
* subject_3_id - ссылка на программу;

#### Mentors
Наставники, ведущие собеседования и образовательные программы.
* fio - ФИО;
* phone - контактный телефон;
* birthdate - дата рождения;
* email - адрес электронной почты;
* education_id - ссылка на учебное заведения, выпускником которого является;

#### Mentors_to_Programs 
Таблица, описывающая, какие наставники какие программы могут вести. Несколько наставников могут вести одну и ту же программу, и один наставник может вести одновременно несколько программ.
* mentor_id - ссылка на наставника;
* program_di - ссылка на программу;

#### Interviews
Собеседования с кандидатами, на основании которых те либо становятся учащимися, либо нет.
* date - дата и время собеседования;
* candidate_id - ссылка на собеседуемого кандидата;
* interviewer_id - ссылка на собеседующего ментора;
* result_id - результат собеседования, выбирается из перечня состояний;
* comment - комментарий к собеседованию для прояснения состояния;

#### Rooms
Аудитории, в которых ведутся занятия, необходимы для составления расписания и расчёта нагрузки на оборудование.
* name - название аудитории;

#### Study_groups
Учебные группы, в которые объединяются учащиеся по одной программе.
* program_id - ссылка на образовательную программу;
* cipher - шифр группы, уникальное имя;
* type_id - тип группы (младшая, взрослая);
* start_date - дата начала обучения;
* end_date - дата завершения обучения;
* creation_order - документ о создании группы;
* expulsion_order - документ о роспуске группы;

#### Students
Кандидаты, прошедшие собеседование и ставшие учащимися, причисленными к учебной группе.
* candidate_id - ссылка на кандидата, так как один кандидат может учиться не более чем в двух группах одновременно;
* interview_id - собеседование, на базе которого был зачислен;
* group_id - группа, куда зачислен;
* education_status_id - состояние (зачислен, завершил, отчислен, и тд...)


## Вопросы
1) Preferred_subjects - что если такое направление изменено или удалено?
2) Стоит ли вообще в кортеже иметь поле для атрибута "удалён"?
3) Нужна ли таблица связи наставников и учебных групп?
4) Какие ещё есть способы реализации связи "многий ко многим"?
5)