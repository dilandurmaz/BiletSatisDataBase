--SORGULAR
-- soyisminde AY harfi bulunan  01-01-2019 tarihinde sefer yapm�� bilet fiyat� 70 tl olan b�t�n Yolcular�n ad�n� soyad�n� do�um tarihini ve cinsiyetini listeleyin.
select Ad,Soyad,D_Tarihi,Cinsiyet 
From Yolcu y inner join Bilet b on
y.yolcuID=b.BiletID
inner join Sefer s on
b.BiletID=s.seferID
where y.Soyad LIKE '%ay%' AND b.Fiyat='70'

-- 25 ve 29 ya� aras�nda  olan 01-01-2000 ve 01-01-2019 tarihleri aras�nda Adanadan Ad�yamana sefer yapm�� ve bilet fiyat� 50 tl olan b�t�n yolcular� listeleyiniz.
select Ad,Soyad,D_Tarihi,Cinsiyet
From Yolcu y inner join Bilet b on
y.yolcuID=b.BiletID inner join Sefer s on
b.BiletID= s.seferID where (y.D_Tarihi>='1990-01-01'and y.D_Tarihi<='1994-01-01') and (s.kalkis_tarihi>='2000-01-01'and s.kalkis_tarihi='2019-01-01') and s.kalkisterminalID=1
and s.varisterminalID=2 and b.Fiyat='50'







--  iptal edilen biletlerden kredi kart� ile �deme yapan m��terilerden ad�nda '�'  bulunup soyisminde 'k' ge�en bilet fiyat� '50 tl' olan m��terileri listeleyiniz.
	
	select Datediff(year,D_Tarihi,GetDate())
	from Yolcu y inner join Bilet b on b.BiletID=y.yolcuID

	where y.Ad LIKE '%�%'and y.Soyad LIKE'%k%' and b.Fiyat='50' and b.Durum=0
	






-- marka ad� dennis olan arac�n yolcu kapasitesi
Select yolcu_kapasitesi
from Arac a inner join Marka m ON
a.aracID=m.MarkaID
where m.MarkaAd�='DENN�S'
--Bu ay i�inde Pamukkale firmas�ndan hem Ankara-�stanbul hem de �zmir-�stanbul otob�s bileti alan yolcular�n tcno,ad soyad bilgileri

select tc, ad, soyad
from Yolcu y inner join Bilet b on y.yolcuID=b.BiletID inner join Il i on b.BiletID=i.ilID inner join Sefer s on s.seferID=b.BiletID inner join Firma f on
f.FirmaID=b.BiletID 
where s.kalkisterminalID=06 and s.varisterminalID=34 and f.FirmaAd='Pamukkale Turizm'
Intersect
select tc,ad,soyad
from Yolcu y inner join Bilet b on y.yolcuID=b.BiletID 
inner join Sefer s on s.seferID=b.BiletID inner join  Firma f on f.FirmaID=b.BiletID inner join Il i on b.BiletID=i.ilID 
where s.kalkisterminalID=35 and s.varisterminalID=34 and f.FirmaAd='Pamukkale Turizm'

-- THY yollar� i�in 2018 y�l�nda en az doluluk oran�na sahip oldu�u ilk 3 ay da seyahat eden yolcular�n bilgileri.
select top 3 tc,ad,soyad
from yolcu y inner  join Bilet b on b.BiletID=y.yolcuID inner join
Sefer s on s.seferID = b.BiletID inner join Arac a on a.aracID=b.BiletID inner join Firma f on f.FirmaID=a.aracID
where FirmaAd='THY' and s.kalkis_tarihi like '%2018%'
order by yolcu_kapasitesi desc





--UPDATE

--Bagaj kg 150 olan yolcular�n bagajlar�n +5kg ekleyip bagaj kg� 50 nin alt�nda olanlara 10 kg ekleyerek update edin.
-- B�LET IDS� 1 OLAN YOLCUNUN BAGAJKG I 150YD� +5 EKLEND�. 17,18,37,38 IDL� YOLCULARIN BAGAJKGI 0 DI 10 EKLEND�. 23 IDLI YOLCUNUN BAGAJKG I 13T� 10 EKLEND�. 29 IDLI YOLCUNUN 
--BAGAJKGI 45T� 10 EKLEND�.
 Select BagajKg,BiletID
 from Bilet
 update Bilet Set BagajKg=(case when BagajKg=150 Then BagajKg+5
							when BagajKg<50 then BagajKg+10
							else BagajKg
							END) 




--Mail adresinde 'GUN' harfleri bulunan personellerden g�revi sat�� dan��man� olanlar�n g�revini muavin olarak update et.
-- IDsi 1 olan personelin mail adresinde 'gun ' harfleri bulunuyordu. ve g�revi sat�� dan��man�yd�. g�revi muavin olarak de�i�tirildi.
Update G�rev Set A��klama ='Muavin'
From Personel AS P inner join G�rev g on
p.personelID=g.G�revID
where p.Mail LIKE '%gun%'and g.A��klama='Sat�� Dan��man�'

Select A��klama
from G�rev



--Telefon numaras�nda 532 bulunan  olan yolculardan cinsiyetleri kad�n olanlar�n bilet fiyatlar�n� 50 tl artt�rarak update et.
--IDS� 5 OLAN YOLCU �ARTLARI SA�LADI�I ���N B�LET F�YATI 50 TL ARTTIRILDI
Update Bilet set Fiyat= Fiyat+50
From Yolcu y inner join bilet b on
y.yolcuID=b.BiletID 
where y.Tel LIKE '%532%'  and y.Cinsiyet='kad�n'

select BiletID,fiyat
from bilet


-- Kredi kart�yla �deme yapan yolcular�n biletlerini iptal ederek update et.
-- kredi kart�yla �deme yapan yolcular�n biletleri iptal edildi.

update Bilet set Durum =0
from Odeme o inner join bilet b on b.BiletID=o.OdemeID
where o.OdemeT�p�='Kredi'




-- �deme tipi banka olan yolculardan '01-01-2019' tarihinde bursaya giden ve erkek olan yolcular�n bilet fiyatlar�n� 15 artt�rarak update et.
-- �art� sa�layan 1  yolcunun bilgileri update edildi.
update Bilet set Fiyat = Fiyat+15
from Yolcu y inner join Bilet b on
y.yolcuID=b.BiletID inner join Sefer s on
s.seferID=b.BiletID
where s.kalkis_tarihi='2019-01-01'and y.Cinsiyet='Erkek'





--DELETE 
--  biletini iptal ettirmi� ve bilet fiyat� 100tl yolcular� sil.
-- foreign key hatas�
delete from Yolcu
where yolcuID IN(select y.yolcuID from Yolcu y where exists (select * from Yolcu inner join Bilet b on b.BiletID=y.yolcuID where b.Durum='0' and b.Fiyat='100'))

-- yolcu kapasitesi 100 olan firmay� sil.

delete from Firma 
where FirmaID IN(select f.firmaID from Firma f where exists(select* from firma inner join Arac a  on f.FirmaID=a.aracID where a.yolcu_kapasitesi=40))
select *
from Firma

--yolcu kapasitesi 100den k��� olan ara�lar�n firmas�n� sil

delete from firma
where FirmaID IN (select f.firmaID from Firma f where exists(select* from firma inner join arac a on f.FirmaID=a.aracID where  yolcu_kapasitesi <100))

-- model ad� Tourliner L olan arac�n marka Idsini sil

delete from Model
where ModelID in (select m.modelID from Model m where exists(select* from model inner join Arac a on m.ModelID=a.aracID where m.ModelAd�='Tourliner L'  ))

-- mailinde 'gu'bulunan personelin g�revini silin.
delete from G�rev
where G�revID in (select g.g�revID from G�rev g where exists(select* from G�rev inner join Personel p on g.G�revID=p.personelID where p.Mail like '%gu%'))

-- firma ismi pamukkale turizm olan 100 yolcu kapasiteli arac�n modelini silin.
delete from Model
where ModelID in (select m.modelID from Model m where exists(select* from Model inner join Firma f on f.FirmaID=m.ModelID where f.FirmaAd='pamukkale turizm'))


-- iptal edilmi� bileti bulunan ara�lar�n modelini silin.
delete from model
where ModelID in (select m.modelID from Model m where exists(select* from model inner join bilet b on b.BiletID=m.ModelID where b.Durum='0'))

