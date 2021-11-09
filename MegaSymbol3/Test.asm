/*
 * Test.asm
 *
 *  Created: 11.01.2020 14:24:28
 *   Author: User
 */ 
onebutton:
	push r18
	push r20
	push r21
	push r22
	ldi r20,0b00001000
	out DDRC,r20
bb1:	
	ldi r22,0
	ldi r20,49
	LCD_COORD 39,1
	WR_DATA r20
	BIG_DELAY
	BIG_DELAY
	in r21,PINC
	cpi r21,0
	breq bb2
	jmp bbend
bb2:	
	ldi r22,1
	ldi r20,50
	LCD_COORD 39,1
	WR_DATA r20
	BIG_DELAY
	BIG_DELAY
	in r21,PINC
	cpi r21,0
	breq bb3
	jmp bbend
bb3:	
	ldi r22,2
	ldi r20,51
	LCD_COORD 39,1
	WR_DATA r20
	BIG_DELAY
	BIG_DELAY
	in r21,PINC
	cpi r21,0
	breq bb4
	jmp bbend
bb4:	
	ldi r22,3
	ldi r20,52
	LCD_COORD 39,1
	WR_DATA r20
	BIG_DELAY
	BIG_DELAY
	in r21,PINC
	cpi r21,0
	brne bbend
	jmp bb1
bbend:
	sts cur_key,r22
	pop r22
	pop r21
	pop r20
	pop r18
	ret
	.db 0,0,0,0,0,0,0,0,0
	GL: .db 0
	.db 0,0,0,0,0,0,0,0,0
	
sbj: .db "Choose subject      1.geog   2.phy                          3.his    4.lite     !"
	.ORG 0x2000
	// Geography TEST
	//question 1
	T0A: .db "1 Australian capital                    is...                                   !" //81
	T01: .db "Canberra  ! "		//93
	T02: .db "Melbourne ! "		//105
	T03: .db "Pert      ! "		//117
	T04: .db "Sidney    ! "		//129
	//question 2
	T1A: .db "2Where is located                        Ghana?                                 !"
	T11: .db "Africa    ! "		//93
	T12: .db "Asia      ! "		//105
	T13: .db "S.America ! "		//117
	T14: .db "N.America ! "		//129
	//question 3
	T2A: .db "3NOT neighbour of                       China?                                  !"
	T21: .db "Laos      ! "		//93
	T22: .db "CPDR      ! "		//105
	T23: .db "Mongolia  ! "		//117
	T24: .db "Russia    ! "		//129
	//question 4
	T3A: .db "4The highest point                      in the world                            !"
	T31: .db "Elbrus    ! "		//93
	T32: .db "Everest   ! "		//105
	T33: .db "Monblan   ! "		//117
	T34: .db "Etna      ! "		//129
	//question 5
	T4A: .db "5How many seas                          circle Russia                           !"
	T41: .db "12        ! "		//93
	T42: .db "46        ! "		//105
	T43: .db "7         ! "		//117
	T44: .db "8         ! "		//129
	//question 6
	T5A: .db "6Where in 2019-20                       were biggest fire                       !"
	T51: .db "USA       ! "		//93
	T52: .db "Australia ! "		//105
	T53: .db "N.Zealand ! "		//117
	T54: .db "Ukrain    ! "		//129
	//question 7
	T6A: .db "7Where is located                       the driest place?                       !"
	T61: .db "Africa    ! "		//93
	T62: .db "Europe    ! "		//105
	T63: .db "Antarctida! "		//117
	T64: .db "Asia      ! "		//129
	//question 8
	T7A: .db "8How many counries                      in the EU?                              !"
	T71: .db "30        ! "		//93
	T72: .db "28        ! "		//105
	T73: .db "24        ! "		//117
	T74: .db "8         ! "		//129
	//question 9
	T8A: .db "9How many rivers                        in SpB?                                 !"
	T81: .db "78        ! "		//93
	T82: .db "201       ! "		//105
	T83: .db "89        ! "		//117
	T84: .db "76        ! "		//129
	//question 10
	T9A: .db "10The deepest metro                     station located..                       !"
	T91: .db "SpB       ! "		//93
	T92: .db "Moscow    ! "		//105
	T93: .db "Kiev      ! "		//117
	T94: .db "Hongkong  ! "		//129
	GR: .db 0,0,0,1,0,1,2,1,2,2,'!'
	//History test
//question 1
	H0A: .db "1When was Lenin                         born?                                   !" //81
	H01: .db "1875      ! "		//93
	H02: .db "1865      ! "		//105
	H03: .db "1240      ! "		//117
	H04: .db "1880     ! "		//129
	//question 2
	H1A: .db "2How many years has                     100-y war continued?                    !"
	H11: .db "1000      ! "		//93
	H12: .db "116       ! "		//105
	H13: .db "10        ! "		//117
	H14: .db "99        ! "		//129
	//question 3
	H2A: .db "3Who launched first                     rocket in space?                        !"
	H21: .db "W.Braun   ! "		//93
	H22: .db "Korolev   ! "		//105
	H23: .db "Lenin     ! "		//117
	H24: .db "Sakharov  ! "		//129
	//question 4
	H3A: .db "4Who invented first                     autocar?                                !"
	H31: .db "Sikorskiy ! "		//93
	H32: .db "Benz      ! "		//105
	H33: .db "Ford      ! "		//117
	H34: .db "Porsche   ! "		//129
	//question 5
	H4A: .db "5When was the civil                     in USA?                                 !"
	H41: .db "1786-89   ! "		//93
	H42: .db "1855-58   ! "		//105
	H43: .db "1861-65   ! "		//117
	H44: .db "1888-93   ! "		//129
	//question 6
	H5A: .db "6The biggest battle                     in WWI                                  !"
	H51: .db "Somma     ! "		//93
	H52: .db "Verdun    ! "		//105
	H53: .db "Lodz      ! "		//117
	H54: .db "Ipres     ! "		//129
	//question 7
	H6A: .db "7Where started 1st                      ind. revolution?                        !"
	H61: .db "USA       ! "		//93
	H62: .db "Rus.Emp   ! "		//105
	H63: .db "UK        ! "		//117
	H64: .db "France    ! "		//129
	//question 8
	H7A: .db "8WHen WWII was                          started?                                !"
	H71: .db "1938      ! "		//93
	H72: .db "1914      ! "		//105
	H73: .db "2014      ! "		//117
	H74: .db "1939      ! "		//129
	//question 9
	H8A: .db "9How old Alex                           Macedonian died?                        !"
	H81: .db "24        ! "		//93
	H82: .db "51        ! "		//105
	H83: .db "32        ! "		//117
	H84: .db "18        ! "		//129
	//question 10
	H9A: .db "10Where was Tesla                       born?                                   !"
	H91: .db "Zagreb    ! "		//93
	H92: .db "Smilyan   ! "		//105
	H93: .db "Vienna    ! "		//117
	H94: .db "Belgrad   ! "		//129
	HR: .db 0,1,0,1,2,1,2,3,2,1
	//physics test
//question 1
	P0A: .db "1Current power                          measured in..                           !" //81
	P01: .db "Farad     ! "		//93
	P02: .db "Amper     ! "		//105
	P03: .db "Watt      ! "		//117
	P04: .db "Pascal    ! "		//129
	//question 2
	P1A: .db "2 30-th element from                    Mendeleev's table is                    !"
	P11: .db "Zincum    ! "		//93
	P12: .db "Cuprum    ! "		//105
	P13: .db "Brom      ! "		//117
	P14: .db "Carbon    ! "		//129
	//question 3
	P2A: .db "3Atom weight of                         Uranium                                 !"
	P21: .db "238       ! "		//93
	P22: .db "247       ! "		//105
	P23: .db "236       ! "		//117
	P24: .db "235       ! "		//129
	//question 4
	P3A: .db "4Ohm's law                                                                      !"
	P31: .db "I=U*R     ! "		//93
	P32: .db "U=I^2/R   ! "		//105
	P33: .db "I=U/R     ! "		//117
	P34: .db "R=Q/U     ! "		//129
	//question 5
	P4A: .db "5Who created rel.                       theory?                                 !"
	P41: .db "Bor       ! "		//93
	P42: .db "Tesla     ! "		//105
	P43: .db "Einstein  ! "		//117
	P44: .db "Curie     ! "		//129
	//question 6
	P5A: .db "6How many Newton's                      laws?                                   !"
	P51: .db "2         ! "		//93
	P52: .db "3         ! "		//105
	P53: .db "4         ! "		//117
	P54: .db "5         ! "		//129
	//question 7
	P6A: .db "7 G constant is                      equal to(on equator)                       !"
	P61: .db "9.786     ! "		//93
	P62: .db "9.782     ! "		//105
	P63: .db "9.790     ! "		//117
	P64: .db "9.780     ! "		//129
	//question 8
	P7A: .db "8Who prototiped the                  first parachute?                           !"
	P71: .db "Wright    ! "		//93
	P72: .db "Wleft     ! "		//105
	P73: .db "Tupolev   ! "		//117
	P74: .db "Da Vinci  ! "		//129
	//question 9
	P8A: .db "9Mendeleev-Claipero                  ne formule?                                !"
	P81: .db "PV=uRT    ! "		//93
	P82: .db "F=ma      ! "		//105
	P83: .db "I=U/R     ! "		//117
	P84: .db "PT=uRV    ! "		//129
	//question 10
	P9A: .db "10The density of                     mercury(element)                           !"
	P91: .db "13600     ! "		//93
	P92: .db "8500      ! "		//105
	P93: .db "1488      ! "		//117
	P94: .db "8800      ! "		//129
	PR:	.db 1,0,0,2,2,1,1,3,0,0
//literature test
//question 1
	L0A: .db "1Whose used alies                    Eid True God                               !" //81
	L01: .db "Pushkin   ! "		//93
	L02: .db "Newton    ! "		//105
	L03: .db "da Vinci  ! "		//117
	L04: .db "Fromm     ! "		//129
	//question 2
	L1A: .db "2Who wrote 'Mumu'?                                                              !"
	L11: .db "Turgenev  ! "		//93
	L12: .db "Tolstoi   ! "		//105
	L13: .db "Gorkiy    ! "		//117
	L14: .db "Fet       ! "		//129
	//question 3
	L2A: .db "3How old Lermontov                    died?                                     !"
	L21: .db "26        ! "		//93
	L22: .db "28        ! "		//105
	L23: .db "27        ! "		//117
	L24: .db "29        ! "		//129
	//question 4
	L3A: .db "4Who wrote 'Illiada'                                                            !"
	L31: .db "Diogen    ! "		//93
	L32: .db "Homer     ! "		//105
	L33: .db "Sokrat    ! "		//117
	L34: .db "Odissey   ! "		//129
	//question 5
	L4A: .db "5How many hell's                      levels in God comedy                      !"
	L41: .db "7         ! "		//93
	L42: .db "3         ! "		//105
	L43: .db "9         ! "		//117
	L44: .db "13        ! "		//129
	//question 6
	L5A: .db "6Which alias use                      G.S. Chartishvili?                        !"
	L51: .db "Akunin    ! "		//93
	L52: .db "Pelevin   ! "		//105
	L53: .db "Dontsova  ! "		//117
	L54: .db "Martin    ! "		//129
	//question 7
	L6A: .db "7How many books in                    Song of Ice and Fire                      !"
	L61: .db "4         ! "		//93
	L62: .db "3         ! "		//105
	L63: .db "6         ! "		//117
	L64: .db "5         ! "		//129
	//question 8
	L7A: .db "8When was published                   book'The Last Wish'?                      !"
	L71: .db "1995      ! "		//93
	L72: .db "1993      ! "		//105
	L73: .db "1997      ! "		//117
	L74: .db "2000      ! "		//129
	//question 9
	L8A: .db "9How many words in                    War and Peace?                            !"//81
	L81: .db "7603      ! "		//93
	L82: .db "32154     ! "		//105
	L83: .db "188088    ! "		//117
	L84: .db "422656    ! "		//129
	//question 10
	L9A: .db "10The main villain                    in Lord of the Rings                      !"
	L91: .db "Gendalf   ! "		//93
	L92: .db "Frodo     ! "		//105
	L93: .db "Lector    ! "		//117
	L94: .db "Sauron    ! "		//129
	LR: .db 1,0,1,1,3,0,3,1,2,3

RES: .db "Yo've completed the Result:             test                                    !"
	.db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	.db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	.db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	.db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0