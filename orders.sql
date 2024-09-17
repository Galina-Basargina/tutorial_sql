drop table if exists order_compositions;
drop table if exists orders;
drop type if exists delivery_type;
drop table if exists products;
drop table if exists product_types;
drop table if exists suppliers;
drop table if exists employee;
drop table if exists clients;

create table clients (
	id text not null primary key,
	title text not null,
	belong_to text not null,
	position text not null,
	address text not null,
	city text not null,
	region text,
	zip_code text,
	country text not null,
	phone text not null,
	fax text
);

create table employee (
	id integer not null primary key,
	chief integer references employee(id),
	last_name text not null,
	first_name text not null,
	position text not null,
	appeal text not null,
	birthdate date not null,
	employment_date date not null,
	address text not null,
	city text not null,
	region text,
	zip_code text not null,
	country text not null,
	home_phone text,
	extension_phone text,
	photo text,
	notes text
);

create table suppliers (
	id integer not null primary key
);

create table product_types (
	id integer not null primary key
);

create table products (
	id integer not null primary key,
	supplier integer not null references suppliers(id),
	type integer not null references product_types(id),
	name text not null,
	unit text not null,
	price money not null,
	remain integer not null,
	expected integer not null default 0,
	min_stock integer not null default 0,
	deliveries_stopped bool not null default false
);

create type delivery_type as enum ('post', 'rostrans', 'other');

create table orders (
	id integer not null primary key,
	client integer not null references clients(id),
	employee integer not null references employee(id),
	issue_date date not null default current_date,
	processing_date date,
	execution_date date,
	delivery delivery_type not null,
	delivery_cost money not null,
	delivery_address text not null,
	delivery_city text not null,
	delivery_region text,
	delivery_zip_code text not null,
	delivery_country text not null
);

create table order_compositions (
	"order" integer not null references orders(id),
	product integer not null references products(id),
	price money not null,
	amount integer not null,
	discount double precision not null default 0.0
);

insert into clients (id,title,belong_to,"position",address,city,region,zip_code,country,phone,fax) values
	 ('BOTTM','Bottom-Dollar Markets','Elizabeth Lincoln','Бухгалтер','23 Tsawassen Blvd.','Тсавассен','BC','T2F 8M4','Канада','(604) 555-4729','(604) 555-3745'),
	 ('GROSR','GROSELLA-Restaurante','Manuel Pereira','Совладелец','5S Ave. Los Palos Grandes','Каракас','DF','1081','Венесуэла','(2) 283-2951','(2) 283-3397'),
	 ('HANAR','Hanari Carnes','Mario Pontes','Бухгалтер','Rua do Paco, 67','Рио-де-Жанейро','RJ','05454-876','Бразилия','(21) 555-0091','(21) 555-8765'),
	 ('HILAA','HILARION-Abastos','Carlos Hernandez','Представитель','Carrera 22 con Ave. Carlos Soublette #8-35','Сан-Кристобаль','Tochira','5022','Венесуэла','(5) 555-1340','(5) 555-1948'),
	 ('HUNGC','Hungry Coyote Import Store','Yoshi Latimer','Представитель','City Center Plaza
516 Main St.','Элгин','OR','97827','США','(503) 555-6874','(503) 555-2376'),
	 ('LAUGB','Laughing Bacchus Wine Cellars','Yoshi Tannamuri','Помощник менеджера','1900 Oak St.','Ванкувер','BC','V3F 2K1','Канада','(604) 555-3392','(604) 555-7293'),
	 ('LAZYK','Lazy K Kountry Store','John Steel','Главный менеджер','12 Orchestra Terrace','Уолла-Уолла','WA','99362','США','(509) 555-7969','(509) 555-6221'),
	 ('ALFKI','Alfreds Futterkiste','Maria Anders','Представитель','Obere Str. 57','Берлин',NULL,'12209','Германия','030-0074321','030-0076545'),
	 ('ANATR','Ana Trujillo Emparelados','Ana Trujillo','Совладелец','Avda. de la Constitucion 2222','Мехико',NULL,'050221','Мексика','(5) 555-47291','(5) 555-3745'),
	 ('AROUT','Around the Horn','Thomas Hardy','Представитель','120 Hanover Sq.','Лондон',NULL,'WA1 1DP','Великобритания','(171) 555-7788','(171) 555-6750'),
	 ('BERGS','Berglunds snabbkop','Christina Berglund','Координатор','Berguvsvagen  8','Лулео',NULL,'S-958 22','Швеция','0921-12 34 65','0921-12 34 67'),
	 ('BLAUS','Blauer See Delikatessen','Hanna Moos','Представитель','Forsterstr. 57','Мангейм',NULL,'68306','Германия','0621-08460','0621-08924'),
	 ('BLONP','Blondel pere et fils','Frederique Citeaux','Главный менеджер','24, place Kleber','Страсбург',NULL,'67000','Франция','88.60.15.31','88.60.15.32'),
	 ('BOLID','Bolido Comidas preparadas','Martin Sommer','Совладелец','C/ Araquil, 67','Мадрид',NULL,'28023','Испания','(91) 555 22 82','(91) 555 91 99'),
	 ('BONAP','Bon app''','Laurence Lebihan','Совладелец','12, rue des Bouchers','Марсель',NULL,'13008','Франция','91.24.45.40','91.24.45.41'),
	 ('CACTU','Cactus Comidas para llevar','Patricio Simpson','Продавец','Cerrito 333','Буэнос-Айрес',NULL,'1010','Аргентина','(1) 135-5555','(1) 135-4892'),
	 ('CENTC','Centro comercial Moctezuma','Francisco Chang','Главный менеджер','Sierras de Granada 9993','Мехико',NULL,'05022','Мексика','(5) 555-3392','(5) 555-7293'),
	 ('HUNGO','Hungry Owl All-Night Grocers','Patricia McKenna','Ученик продавца','8 Johnstown Road','Корк','Co. Cork',NULL,'Ирландия','2967 542','2967 3333'),
	 ('LILAS','LILA-Supermercado','Carlos Gonzalez','Бухгалтер','Carrera 52 con Ave. Bolivar #65-98 Llano Largo','Баркисимето','Lara','3508','Венесуэла','(9) 331-6954','(9) 331-7256'),
	 ('LINOD','LINO-Delicateses','Felipe Izquierdo','Совладелец','Ave. 5 de Mayo Porlamar','О-в Маргариты','Nueva Esparta','4980','Венесуэла','(8) 34-56-12','(8) 34-93-93'),
	 ('LONEP','Lonesome Pine Restaurant','Fran Wilson','Менеджер по продажам','89 Chiaroscuro Rd.','Портленд','OR','97219','США','(503) 555-9573','(503) 555-9646'),
	 ('MEREP','Mere Paillarde','Jean Fresniere','Помощник менеджера','43 rue St. Laurent','Монреаль','Quebec','H1J 1C3','Канада','(514) 555-8054','(514) 555-8055'),
	 ('OLDWO','Old World Delicatessen','Rene Phillips','Представитель','2743 Bering St.','Анкоридж','AK','99508','США','(907) 555-7584','(907) 555-2880'),
	 ('QUEDE','Que Delicia','Bernardo Batista','Бухгалтер','Rua da Panificadora, 12','Рио-де-Жанейро','RJ','02389-673','Бразилия','(21) 555-4252','(21) 555-4545'),
	 ('RATTC','Rattlesnake Canyon Grocery','Paula Wilson','Помощник представителя','2817 Milton Dr.','Альбукерке','NM','87110','США','(505) 555-5939','(505) 555-3620'),
	 ('SPLIR','Split Rail Beer & Ale','Art Braunschweiger','Менеджер по продажам','P.O. Box 555','Лендер','WY','82520','США','(307) 555-4680','(307) 555-6525'),
	 ('THECR','The Cracker Box','Liu Wong','Помощник менеджера','55 Grizzly Peak Rd.','Бут','MT','59801','США','(406) 555-5834','(406) 555-8083'),
	 ('TRADH','Tradiero Hipermercados','Anabela Domingues','Представитель','Av. Ines de Castro, 414','Сан-Пауло','SP','05634-030','Бразилия','(11) 555-2167','(11) 555-2168'),
	 ('TRAIH','Trail''s Head Gourmet Provisioners','Helvetius Nagy','Ученик продавца','722 DaVinci Blvd.','Керкленд','WA','98034','США','(206) 555-8257','(206) 555-2174'),
	 ('MAGAA','Magazzini Alimentari Riuniti','Giovanni Rovelli','Главный менеджер','Via Ludovico il Moro 22','Бергамо',NULL,'24100','Италия','035-640230','035-640231'),
	 ('MAISD','Maison Dewey','Catherine Dewey','Продавец','Rue Joseph-Bens 532','Брюссель',NULL,'B-1180','Бельгия','(02) 201 24 67','(02) 201 24 68'),
	 ('NORTS','North/South','Simon Crowther','Ученик продавца','South House
300 Queensbridge','Лондон',NULL,'SW7 1RZ','Великобритания','(171) 555-7733','(171) 555-2530'),
	 ('OCEAN','Oceano Atlantico Ltda.','Yvonne Moncada','Продавец','Ing. Gustavo Moncada 8585
Piso 20-A','Буэнос-Айрес',NULL,'1010','Аргентина','(1) 135-5333','(1) 135-5535'),
	 ('OTTIK','Ottilies Kaseladen','Henriette Pfalzheim','Совладелец','Mehrheimerstr. 369','Кельн',NULL,'50739','Германия','0221-0644327','0221-0765721'),
	 ('PARIS','Paris specialites','Marie Bertrand','Совладелец','265, boulevard Charonne','Париж',NULL,'75012','Франция','(1) 42.34.22.66','(1) 42.34.22.77'),
	 ('PERIC','Pericles Comidas clasicas','Guillermo Fernandez','Представитель','Calle Dr. Jorge Cash 321','Мехико',NULL,'05033','Мексика','(5) 552-3745','(5) 545-3745'),
	 ('PICCO','Piccolo und mehr','Georg Pipps','Менеджер по продажам','Geislweg 14','Зальцбург',NULL,'5020','Австрия','6562-9722','6562-9723'),
	 ('RANCH','Rancho grande','Sergio Gutierrez','Представитель','Av. del Libertador 900','Буэнос-Айрес',NULL,'1010','Аргентина','(1) 123-5555','(1) 123-5556'),
	 ('ROMEY','Romero y tomillo','Alejandra Camino','Бухгалтер','Gran Via, 1','Мадрид',NULL,'28001','Испания','(91) 745 6200','(91) 745 6210'),
	 ('WHITC','White Clover Markets','Karl Jablonski','Совладелец','305 - 14th Ave. S.
Suite 3B','Сиэтл','WA','98128','США','(206) 555-4112','(206) 555-4115'),
	 ('COMMI','Comercio Mineiro','Pedro Afonso','Ученик продавца','Av. dos Lusiadas, 23','Сан-Пауло','SP','05432-043','Бразилия','(11) 555-7647',NULL),
	 ('FAMIA','Familia Arquibaldo','Aria Cruz','Помощник менеджера','Rua Oros, 92','Сан-Пауло','SP','05442-030','Бразилия','(11) 555-9857',NULL),
	 ('GOURL','Gourmet Lanchonetes','Andre Fonseca','Ученик продавца','Av. Brasil, 442','Кампинас','SP','04876-786','Бразилия','(11) 555-9482',NULL),
	 ('GREAL','Great Lakes Food Market','Howard Snyder','Главный менеджер','2732 Baker Blvd.','Юджин','OR','97403','США','(503) 555-7555',NULL),
	 ('ISLAT','Island Trading','Helen Bennett','Главный менеджер','Garden House
Crowther Way','Коувс','Isle of Wight','PO31 7PJ','Великобритания','(198) 555-8888',NULL),
	 ('LETSS','Let''s Stop N Shop','Jaime Yorres','Совладелец','87 Polk St.
Suite 5','Сан-Франциско','CA','94117','США','(415) 555-5938',NULL),
	 ('QUEEN','Queen Cozinha','Lucia Carvalho','Помощник менеджера','Alameda dos Canarios, 891','Сан-Пауло','SP','05487-020','Бразилия','(11) 555-1189',NULL),
	 ('RICAR','Ricardo Adocicados','Janete Limeira','Помощник продавца','Av. Copacabana, 267','Рио-де-Жанейро','RJ','02389-890','Бразилия','(21) 555-3412',NULL),
	 ('SAVEA','Save-a-lot Markets','Jose Pavarotti','Представитель','187 Suffolk Ln.','Буа','ID','83720','США','(208) 555-8097',NULL),
	 ('THEBI','The Big Cheese','Liz Nixon','Главный менеджер','89 Jefferson Way
Suite 2','Портленд','OR','97201','США','(503) 555-3612',NULL),
	 ('WELLI','Wellington Importadora','Paula Parente','Менеджер по продажам','Rua do Mercado, 12','Ресенде','SP','08737-363','Бразилия','(14) 555-8122',NULL),
	 ('CONSH','Consolidated Holdings','Elizabeth Brown','Представитель','Berkeley Gardens
12  Brewery ','Лондон',NULL,'WX1 6LT','Великобритания','(171) 555-2282','(171) 555-9199'),
	 ('DRACD','Drachenblut Delikatessen','Sven Ottlieb','Координатор','Walserweg 21','Ахен',NULL,'52066','Германия','0241-039123','0241-059428'),
	 ('DUMON','Du monde entier','Janine Labrune','Совладелец','67, rue des Cinquante Otages','Нант',NULL,'44000','Франция','40.67.88.88','40.67.89.89'),
	 ('EASTC','Eastern Connection','Ann Devon','Продавец','35 King George','Лондон',NULL,'WX3 6FW','Великобритания','(171) 555-0297','(171) 555-3373'),
	 ('ERNSH','Ernst Handel','Roland Mendel','Менеджер по продажам','Kirchgasse 6','Грасс',NULL,'8010','Австрия','7675-3425','7675-3426'),
	 ('FISSA','FISSA Fabrica Inter. Salchichas S.A.','Diego Roel','Бухгалтер','C/ Moralzarzal, 86','Мадрид',NULL,'28034','Испания','(91) 555 94 44','(91) 555 55 93'),
	 ('FOLIG','Folies gourmandes','Martine Rance','Помощник продавца','184, chaussee de Tournai','Лилль',NULL,'59000','Франция','20.16.10.16','20.16.10.17'),
	 ('FRANK','Frankenversand','Peter Franken','Главный менеджер','Berliner Platz 43','Мюнхен',NULL,'80805','Германия','089-0877310','089-0877451'),
	 ('FRANR','France restauration','Carine Schmitt','Главный менеджер','54, rue Royale','Нант',NULL,'44000','Франция','40.32.21.21','40.32.21.20'),
	 ('FRANS','Franchi S.p.A.','Paolo Accorti','Представитель','Via Monte Bianco 34','Турин',NULL,'10100','Италия','011-4988260','011-4988261'),
	 ('FURIB','Furia Bacalhau e Frutos do Mar','Lino Rodriguez ','Менеджер по продажам','Jardim das rosas n. 32','Лиссабон',NULL,'1675','Португалия','(1) 354-2534','(1) 354-2535'),
	 ('GALED','Galeria del gastrуnomo','Eduardo Saavedra','Главный менеджер','Rambla de Cataluna, 23','Барселона',NULL,'08022','Испания','(93) 203 4560','(93) 203 4561'),
	 ('LACOR','La corne d''abondance','Daniel Tonini','Представитель','67, avenue de l''Europe','Версаль',NULL,'78000','Франция','30.59.84.10','30.59.85.11'),
	 ('LAMAI','La maison d''Asie','Annette Roulet','Менеджер по продажам','1 rue Alsace-Lorraine','Тулуза',NULL,'31000','Франция','61.77.61.10','61.77.61.11'),
	 ('LEHMS','Lehmanns Marktstand','Renate Messner','Представитель','Magazinweg 7','Франкфурт',NULL,'60528','Германия','069-0245984','069-0245874'),
	 ('REGGC','Reggiani Caseifici','Maurizio Moroni','Ученик продавца','Strada Provinciale 124','Реджио-Эмилио',NULL,'42100','Италия','0522-556721','0522-556722'),
	 ('SANTG','Santu Gourmet','Jonas Bergulfsen','Совладелец','Erling Skakkes gate 78','Ставерен',NULL,'4110','Норвегия','07-98 92 35','07-98 92 47'),
	 ('SEVES','Seven Seas Imports','Hari Kumar','Менеджер по продажам','90 Wadhurst Rd.','Лондон',NULL,'OX15 4NB','Великобритания','(171) 555-1717','(171) 555-5646'),
	 ('SIMOB','Simons bistro','Jytte Petersen','Совладелец','Vinbaeltet 34','Копенгаген',NULL,'1734','Дания','31 12 34 56','31 13 35 57'),
	 ('SPECD','Specialites du monde','Dominique Perrier','Главный менеджер','25, rue Lauriston','Париж',NULL,'75016','Франция','(1) 47.55.60.10','(1) 47.55.60.20'),
	 ('SUPRD','Supremes delices','Pascale Cartrain','Бухгалтер','Boulevard Tirou, 255','Шарлеруа',NULL,'B-6000','Бельгия','(071) 23 67 22 20','(071) 23 67 22 21'),
	 ('TOMSP','Toms Spezialitaten','Karin Josephs','Главный менеджер','Luisenstr. 48','Мюнстер',NULL,'44087','Германия','0251-031259','0251-035695'),
	 ('VAFFE','Vaffeljernet','Palle Ibsen','Менеджер по продажам','Smagsloget 45','Орхус',NULL,'8200','Дания','86 21 32 43','86 22 33 44'),
	 ('VICTE','Victuailles en stock','Mary Saveley','Продавец','2, rue du Commerce','Лион',NULL,'69004','Франция','78.32.54.86','78.32.54.87'),
	 ('VINET','Vinette bistro','Paul Henriot','Бухгалтер','59 rue de l''Abbaye','Реймс',NULL,'51100','Франция','26.47.15.10','26.47.15.11'),
	 ('WANDK','Die Wandernde Kuh','Rita Muller','Представитель','Adenauerallee 900','Штутгарт',NULL,'70563','Германия','0711-020361','0711-035428'),
	 ('WARTH','Wartian Herkku','Pirkko Koskitalo','Бухгалтер','Torikatu 38','Оулу',NULL,'90110','Финляндия','981-443655','981-443655'),
	 ('WILMK','Wilman Kala','Matti Karttunen','Управляющий','Keskuskatu 45','Хельсинки',NULL,'21240','Финляндия','90-224 8858','90-224 8858'),
	 ('WOLZA','Wolski  Zajazd','Zbyszek Piestrzeniewicz','Совладелец','ul. Filtrowa 68','Варшава',NULL,'01-012','Польша','(26) 642-7012','(26) 642-7012'),
	 ('ANTON','Antonio Moreno Taqueria','Antonio Moreno','Совладелец','Mataderos  2312','Мехико',NULL,'05023','Мексика','(5) 555-3932',NULL),
	 ('BSBEV','B''s Beverages','Victoria Ashworth','Представитель','Fauntleroy Circus','Лондон',NULL,'EC2 5N4T','Великобритания','(171) 555-1212',NULL),
	 ('CHOPS','Chop-suey Chinese','Yang Wang','Совладелец','Hauptstr. 29','Берн',NULL,'3012','Швейцария','0452-076545',NULL),
	 ('FOLKO','Folk och fa HB','Maria Larsson','Совладелец','Lkergatan 24','Брекке',NULL,'S-844 67','Швеция','0695-34 67 21',NULL),
	 ('GODOS','Godos Cocina Tipica','Jose Pedro Freyre','Менеджер по продажам','C/ Romero, 33','Севилья',NULL,'41101','Испания','(95) 555 82 82',NULL),
	 ('KOENE','Koniglich Essen','Philip Cramer','Ученик продавца','Maubelstr. 90','Бранденбург',NULL,'14776','Германия','0555-09876',NULL),
	 ('MORGK','Morgenstern Gesundkost','Alexander Feuer','Помощник менеджера','Heerstr. 22','Лейпциг',NULL,'04179','Германия','0342-023176',NULL),
	 ('PRINI','Princesa Isabel Vinhos','Isabel de Castro','Представитель','Estrada da saude n. 58','Лиссабон',NULL,'1756','Португалия','(1) 356-5634',NULL),
	 ('QUICK','QUICK-Stop','Horst Kloss','Бухгалтер','Taucherstrasse 10','Кюневальд',NULL,'01307','Германия','0372-035188',NULL),
	 ('RICSU','Richter Supermarkt','Michael Holz','Менеджер по продажам','Grenzacherweg 237','Женева',NULL,'1203','Швейцария','0897-034214',NULL),
	 ('TORTU','Tortuga Restaurante','Miguel Angel Paolino','Совладелец','Avda. Azteca 123','Мехико',NULL,'05033','Мексика','(5) 555-2933',NULL);

insert into employee (id,chief,last_name,first_name,"position",appeal,birthdate,employment_date,address,city,region,zip_code,country,home_phone,extension_phone,photo,notes) values
	 (2,NULL,'Новиков','Павел','Вице-президент','др.','1952-02-19','1992-08-14','Судостроительная ул., 12-245','Москва',NULL,'104984','Россия','(095) 555-9482','124-3457','EmpID2.bmp','Защитил докторскую диссертацию на тему международных рыночных отношений. Работал в Министерстве Торговли на различных должностях вплоть до зам.министра по пищевым товарам. Огромный опыт в торговле. Говорит по-английски, по-французски, по-китайски и понимает по-японски. Поступив на должность торгового представителя, быстро пошел вверх и занял должность вице-президента.'),
	 (1,2,'Белова','Мария','Представитель','г-жа','1968-12-08','1992-05-01','ул. Нефтяников, 14-4','Москва',NULL,'122981','Россия','(095) 555-9857','124-5467','EmpID1.bmp','Окончила Институт Пищевой промышленности. Работала продавцом в киоске, так что имеет большие навыки в торговле продовольственными товарами. Отличается исключительным добродушием и мягким характером.'),
	 (3,2,'Бабкина','Ольга','Представитель','г-жа','1963-08-30','1992-04-01','Крещатик, 34-55','Киев',NULL,'229033','Украина','(044) 251-3412','315-3355','EmpID3.bmp','Закончила Киевский университет по специальности "химия".  Окончила специальные курсы по организации хранения пищевых продуктов. Начала работу как представитель в Киеве, быстро распространила деятельность компании на всю Украину, включая Крым и Одессу.'),
	 (4,2,'Воронова','Дарья','Представитель','г-жа','1958-09-19','1993-05-03','ул. Пехотинцев, 1-34','Киев',NULL,'215052','Украина','(044) 315-8122','315-5176','EmpID4.bmp','Окончила с отличием философский факультет Московского университета и Институт легкой промышленности. Временно прикомандирована к Киевскому филиалу компании.'),
	 (5,2,'Кротов','Андрей','Менеджер по продажам','г.','1955-03-04','1993-10-17','Зеленый просп. 24-78','Москва',NULL,'119665','Россия','(095) 408-4848','124-3453','EmpID6.bmp','Выпускник Московского Университета, Андрей долгое время занимался вопросами химического анализа пищи, опубликовал несколько статей и книг по данному вопросу. Окончил курсы повышения квалификации по рекламе на телевидении и радио.'),
	 (6,5,'Акбаев','Иван','Представитель','г.','1963-07-02','1993-10-17','Студенческая ул., 22-15','Москва',NULL,'121246','Россия','(095) 245-7773','124-3568','EmpID5.bmp','Окончил Ташкентский университет (экономический факультет) и Лондонский университет (маркетинг). В течении двух лет проходил стажировку в Японии, в результате чего прекрасно выучил японский язык.'),
	 (7,5,'Кралев','Петр','Представитель','г.','1960-05-29','1994-01-02','Сиреневый бульв. 11-11','Москва',NULL,'111734','Россия','(095) 411-5028','124-3509','EmpID7.bmp','Отслужив в ВДВ, приобрел полезные навыки по работе с клиентами. Прослушал спецкурс по европейской торговле при Институте Международных Отношений. Занимается в основном работой с европейскими поставщиками.'),
	 (8,5,'Крылова','Анна','Внутренний координатор','г-жа','1958-01-09','1994-03-05','Лесная ул. 12-456','Москва',NULL,'105001','Россия','(095) 555-1189','124-2344','EmpID8.bmp','Профессиональный психолог. Занимается анализом работы трудового коллектива и вопросами оптимизации его работы.'),
	 (9,2,'Ясенева','Инна','Представитель','г-жа','1969-07-02','1994-11-15','Родниковый пер. 1','Киев',NULL,'255321','Украина',NULL,'314-0452','EmpID9.bmp','Очень хорошая сотрудница - старательная, добрая, отзывчивая, технически грамотная и во всех отношениях аккуратная. Еще не было ни одного начальника, который был бы хоть чем-то недоволен...');

insert into suppliers select generate_series from generate_series(1,29);
insert into product_types  select generate_series from generate_series(1,8);
