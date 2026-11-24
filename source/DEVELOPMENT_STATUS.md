# MiaPaxERP — geliştirme kaydı, 18 Kasım 2026

## 2.9.10 — 24 Kasım 2026

- Arazi Stüdyosu: "🧹 Temizle" (tarla, borular, analiz silinir; konum korunur; geri alınabilir); "📍 Konumum" canlı konum takibi (WebView konum izni yalnız kroki sayfasına verilir; Windows konum izni açık olmalı); "🗺 Ada / Parsel": resmî TKGM Parsel Sorgu program içinde açılır, kullanıcı sorgular, sitenin indirdiği KML/GeoJSON yakalanıp tarla sınırı olarak aktarılır (TKGM'ye program adına istek gönderilmez). "📂 Aç" KML/GeoJSON parsel dosyasını da aktarır; ada/parsel/mahalle bilgisi proje adına ve adrese yazılır.
- Cam temalarında ince sol menü, modül seçilince kapanır (tıklanan düğmede kalan klavye odağı menüyü açık tutuyordu).
- Boru basınç testleri: "Yeni basınç testi" cihaz (LAB.VIEW) veya parti (WAREHOUSE.VIEW) yetkisi/lisansı olmayan kullanıcıda açılmıyordu; isteğe bağlı listeler artık boş "seçilmedi" ile gelir. Tarih-saat alanı dilden bağımsız okunur (24.11.2026 14:30); doğrulama hatası hangi alanın yanlış olduğunu söyler.
- Hızlı satış / SATIŞ: miktar, fiyat ve toplam Türkçe binlik ayıraçla (4.800,00); genel toplam her satır değişikliğinde (miktar, fiyat, KDV, ekleme, silme) güncellenir; KDV hariç tutar ve KDV ayrıca gösterilir.
- Dil: açık tüm pencereler, açılır paneller (bildirim, öneriler), sağ tık menüleri ve ipuçları çevrilir; yazdırılan FlowDocument'ler (dış ticaret, bordro, sektör raporu, Excel ve Yazdır) çevrilir; laboratuvar/basınç raporu ve tablo PDF'leri HTML olarak çevrilir; Arazi Stüdyosu ve saha pazarlama web ekranları program diliyle gösterilir (`WebCeviri`). Web/rapor verisi sözlükte yoksa değişmez ve yapay zekâya gönderilmez (`Dil.CevirKayitsiz`). Sözlüğe 195 metin eklendi (6 dil).

## Yayımlanmamış (2.9.9 adayı) — 23 Kasım 2026

- Kullanıcı silme: Kullanıcı ve Yetkiler → "🗑 Kullanıcıyı Sil". Hesap listeden kalkar, giriş yapamaz, kullanıcı adı yeniden kullanılabilir; geçmiş belgelerde adı korunur (satır fiziksel silinmez, `~silindi~` önekiyle arşivlenir). Kendi hesabınız ve son aktif yönetici silinemez. HTTPS: `YardimciEkranServisi.KullaniciSil`.
- Üretim: "✎ Emri Düzenle" ve "🗑 Emri Sil" yanlış başlatılan (Üretimde) emirde de çalışır. Önce "başlatmayı geri al" yapılır: gün içinde stoğa giren sağlam ürün ters kayıtla düşülür, sabitlenen reçete kaldırılır, emir Planlandı olur. Paketlenmiş veya stoklara işlenmiş emirde yapılmaz. "Emri İptal Et" de aynı akışı kullanır. HTTPS: `EskiUretimServisi.BaslatmayiGeriAl`.
- İş takvimi: "✓ Tamamlandı", "✎ Düzenle", "İptal et", "🗑 Sil" düğmeleri; çift tıkla düzenleme, sağ tık menüsü. HTTPS: `TakvimGetir`, `TakvimGuncelle`, `TakvimSil`.
- Bugün yapılacaklar: rol/yetki ve takvime göre öncelikli günlük görevler (ay sonu kapanışı, KDV 28'i, muhtasar 26'sı, geçici vergi, Ba-Bs; bordro/puantaj; ay sonu ve ön sayım; teslimi yaklaşan satın alma siparişleri için mal kabul hazırlığı; bugün başlayacak üretim; bugün vadeli ödeme ve çek/senet; bugünkü takvim planları). Ana sayfada "📌 Bugün yapılacaklar" kartı ve 💡 Öneriler penceresinin başında. HTTPS: `AkilliDenetimServisi.BugunYapilacaklar`.
- Temaya göre pano: her tema kendi widget setini gösterir — Nane Cam ekip + istatistik, Okyanus Cam finans akışı, Lavanta Cam görev panosu, Gün Batımı Cam satış vitrini, Gece Cam üretim kontrol odası, VIP yönetici özeti, Eskitme/Klasik defter görünümü, Doğal/Kültürel günün akışı, Modern/Yenilikçi/Canlı gösterge ızgarası. Veri `PanoOzetiServisi.Oku` ile yetkiye göre okunur.
- Kroki → Arazi Stüdyosu (tek ekran, `Assets/KrokiWeb/arazi.html`): adres/koordinat arama (OpenStreetMap Nominatim), Esri uydu üzerinde tarla çizimi (köşe veya ölçüyle), su kaynağı, ana/dağıtım/hat borusu, yağmurlama başlığı ve 14 çeşit ek parçanın elle eklenmesi (boruya otomatik oturur), seç/taşı/sil, tarlayı borularla birlikte taşıma, geri al; otomatik yerleşim (mevcut hesap motoru); 3D uydu görünümü (uydu dokusu gerçek arazi yüksekliğine giydirilir); toprak (ISRIC SoilGrids: pH, tekstür, organik madde, N, KDK, WRB), meteoroloji (Open-Meteo 7 gün + son 12 ay), eğim (Copernicus DEM) ve ürüne göre sulama ihtiyacı; stok fiyatlı malzeme listesi; yapay zekâ ile anlatımdan adres → tarla → kaynak → borular → analiz → fiyat (sunucu yoksa yerleşik çözümleyici). PDF: yukarıdan ve 3D uydu görünümü, malzeme/teklif, en altta analiz. Önceki planlayıcı ve AI sihirbazı "Klasik araçlar"dan açılır. Testler: `tests/arazi.test.mjs`.
- Not: Esri World Imagery ticari kullanımda Esri koşullarına tabidir; raporda kaynak atıfları yer alır.
- Saha pazarlama: müşteri kartında "🗑 Müşteriyi sil" (masaüstü ve telefon; görüşmeler ve geçmişle birlikte, sürüm kontrollü; WhatsApp gönderim kayıtları korunur, müşteri bağı boşaltılır). HTTPS `SahaServisi.Sil`, mobil `delete`.
- Saha pazarlama: kart güncellenince değişen alanlar ("Tarla: 10 dekar → 12 dekar") tarih ve kullanıcı adıyla `BERP299_SahaGecmis` tablosuna yazılır; kartın zaman çizelgesinde görüşmelerle birlikte, il listesinde "son işlem" olarak görünür. Rapor tarih aralığına o aralıkta eklenen, güncellenen veya görüşülen müşteriler girer; "Son işlem" sütunu eklendi. Test: `SahaGecmisSqlTestleri`.
- Mobil tema: koyu tema sayfayı `filter:invert` ile ters çevirmiyor (bazı Android WebView'ler yazıyı çizmiyordu); açık ve koyu tema için her öğenin zemin/yazı rengi açıkça tanımlı, telefonun koyu/açık modundan etkilenmez. Telefona ulaşması için yeni APK gerekir.

## 2.9.2 — birim fiyat ve KDV, makine yönetimi, kroki AI proje sihirbazı, modül modül lisans (yayımlanıyor)

- Birim fiyat ve KDV (StokFiyatKdvServisi/Penceresi): mevcut ve üretilen stoklarda alış fiyatı (KDV dahil/hariç), bayi ve perakende fiyatı, KDV oranı %0/%1/%10/%20 (varsayılan %20). Tablo MPXNext_StokKdv (Sema.sql, ModullerNext.sql, çalışma anında idempotent). Girişler: Satış/Üretilen stok panelinde "Birim fiyat ve KDV" ve stok menüsünde "Birim fiyat ve KDV listesi". Kroki teklif stok aramasına KDV oranı ve dahil/hariç bilgisi taşındı.
- Makine yönetimi (ayrı lisans modülü MAKINA, yetkiler MACHINE.VIEW/MACHINE.MANAGE): MPXNext_Makine tablosunda bağlantı ve veri alanları (JSON). Okuma bu bilgisayardan, aynı ağdaki makineden yapılır ve veritabanına yazılmaz:
  - Modbus TCP (FC1–4, U16/S16/U32/S32/F32, kelime sırası ters :SW)
  - MQTT 3.1.1 (yalnız abone, QoS0, konu#json.yol)
  - HTTP/JSON (nokta yolu)
  - OPC UA: dış kütüphane yok (OPC Foundation yığını üye olmayanlara GPL 2.0 olduğu için kullanılmadı); kendi ikili istemci, SecurityPolicy None + anonim, yalnız Read.
  Panelde her makine için canlı kart (durum rengi, değerler, hedefe göre %, geçmiş grafiği), ayrıntı penceresi ve "Bağlantıyı dene" düğmeli düzenleyici.
- Kroki yönetimi: "🤖 Yapay zekâ proje sihirbazı" sekmesi (Assets/KrokiWeb/ai-proje.html). Tarla ölçüsü, sulama türü (damla/yağmurlama/mini), boru malzemesi ve çapı, aksesuarlar, su kaynağının türü/yönü/uzaklığı/kuyu derinliği girilir veya serbest Türkçe anlatılır. Bağlantısız hesap motoru (js/ai-project.mjs) yerleşim, bölüm (vana) sayısı, Hazen–Williams kayıpları, pompa basma yüksekliği ve gücü, ürün bazında malzeme listesi üretir; 3D görünüm (three.js), stoktan fiyat + KDV eşleştirme, CSV ve PDF. Yapay zekâ bağlıysa anlatım projectAsk mesajıyla parametreye çevrilir; yanıt yalnız izinli alanlarla kabul edilir.
- Lisans modül kataloğu 3: DEPO, MALIYET, HIZLISATIS, SAHA, CEKSENET, BASINC, TAKVIM, ILETISIM, ASISTAN, PIYASA, MAKINA panelden ayrı verilebilir. Eski (katalog belirtmeyen) istemci ve lisanslarda alt modüller ana modülle açık kabul edilir; panel eski istemcilere yalnız eski modül listesini imzalar.
- Kullanıcı geri bildirimiyle yapılan düzeltmeler (18 Kasım 2026):
  - Satış: yeni satışta miktar girilince program kapanıyordu (düzenleme sırasında tablo yenileme). Satır modeli artık değişiklik bildiriyor; beklenmeyen ekran hataları programı kapatmadan bildiriliyor.
  - Hızlı satış modülü kaldırıldı (menü, lisans kataloğu, paneller); normal satış aynı ekranla devam ediyor. Eski QUICKSALE lisansı SATIS'a eşlenir.
  - Üretim: üretim emrine kaydedilen günlük üretilen miktar o anda mamul stoğuna girer (MPXNext_UretimGunlukStok ile fark kaydı); emir tamamlanınca yalnız kalan fark işlenir.
  - Stok: otomatik barkod 8 haneli EAN-8 (2…); miktar kutularında Türkçe binlik/ondalık biçim (SayiKutusu); "Seçili hareketi iptal et" (manuel giriş/çıkışta ters kayıt, ikinci iptal engelli); stok kartı aramasında tam eşleşmede satır seçilip kutu temizlenir.
  - Fiyat yetkisi STOCK.PRICE: stok kartında alış/satış/bayi fiyatı ve KDV alanları yalnız bu yetkiyle görünür; satın alma, muhasebe, finans ve satış rollerine bir kez otomatik verilir, Kullanıcı ve Yetkiler'den atanabilir.
  - Satın alma: mal kabul ve doğrudan alışta stok hareketiyle birlikte alım kaydı (son alış fiyatı) yazılır; satın alma ekranından "Yeni ürün kartı" açılabilir.
  - İK: izin günü vb. miktarlarda gereksiz ondalık/virgül gösterimi kaldırıldı.
  - Bordro: çalışan ücretleri (MPXNext_PersonelUcret), "Bugünkü hak ediş · tüm çalışanlar" günlük otomatik hesap (10 dakikada bir, gün değişince yenilenir), ay sonu taslak bordroları.
  - MRP ve maliyet: birim fiyat sırası stok alış maliyeti (KDV ayrılır) → son alış → lot maliyeti; ihtiyaç tablosunda birim fiyat ve tutar sütunları, fiili tüketim yoksa reçete tahmini.
  - Kroki: otomatik çap hesabı varsayılan kapalı; açılırsa kullanıcının girdiği çapı yalnız büyütür (her seferinde 63x40'a dönme hatası).
  - Laboratuvar: kurulu değilse kurulum önerilir; yeni test stok numunesi (bakiyeli) veya depo partisinden başlar; liste "parti kod" sütunu kaldırıldı.
  - Basınç testleri: düğmeler hata gösterir (tablo yoksa kurulum ipucu); lot/cihaz seçimi isteğe bağlı.
  - Dış ticaret: stoktan ürün ekleme (fiyat/KDV), KDV oranı uygulama, satır silme, canlı özet (brüt, indirim, KDV dökümü, kg), GTİP ve net kg sütunları, proforma Excel.
  - Firma bilgileri: eklenen PDF'ten unvan, VKN/TCKN, vergi dairesi, MERSİS, sicil, NACE, IBAN, iletişim ve adres boş alanlara doldurulur (pdf.js, bağlantısız).
  - Temalar: koyu temalarda sabit açık zeminler koyulaştırılır, sekme değişiminde okunurluk yeniden denetlenir.
  - Dil: Ayarlar'da Türkçe, English, Deutsch, Français, Русский, العربية (sağdan sola), 中文. Menüler ve sık kullanılan ekran metinleri yerleşik sözlükten (Diller/ceviri.tsv, ~330 metin) çevrilir; sözlükte olmayanlar yapay zekâ bağlantısıyla tamamlanıp %LOCALAPPDATA%\MiapaxERP\Ceviri altında saklanabilir. Kayıt verileri çevrilmez.
  - 19 Kasım 2026 (sürüm 2.9.5): lisans başına mobil cihaz sayısı (panellerde 📱 düğmesi, license_mobile tablosu, imzalı lisansta mobileDevices); eşlemede sınır denetimi ve gerçek hata nedeni (403 mesajı telefona iletilir); mobil uzak bağlantı sonucu penceresi. Not: internet paneli kodu canlıya ayrıca dağıtılmalıdır.
  - 19 Kasım 2026 öğleden sonra (sürüm 2.9.4): yan PC açılışı (kısayol --https-client, kayıtlı sunucuda ayar ekranı atlanır), son dakika bandı, lisans duyuruları 10 dk, mobil tema/yazı boyutu ayarı, Kroki ve mobil açılır liste renkleri.
  - 19 Kasım 2026 ek düzeltmeler (sürüm 2.9.3):
    - Mobil: masaüstünde sade 3 adımlı bağlantı ekranı, dış IP (otomatik bulma, port, sertifikada dış IP), yerel/dış adres yedekli eşleme kodu (BERP-LAN1 v2 "alt"), "Yapay zekâ ile denetle ve düzelt"; telefonda sade bağlantı ekranı, nedenini gösteren bildirim kutucuğu, "Hesap değiştir", kod yoksa yapıştırma penceresi, telefon bildirimleri (60 sn), iş takvimi, bildirimler okundu işareti, çevrimdışı önbellek genişletildi.
    - Mobil harita: provinces.geojson / districts.geojson APK'ya geri eklendi (kaynak arşivinde eksikti).
    - "Mobil kullanıcılar" departmanı etkin mobil hesaplarla otomatik eşitlenir; duyuru/mesaj bu departmana gönderilebilir.
    - Üretilen ürünler stoku: üretim emirlerinden gelen girişler (tamamlama ve günlük kayıt) de listelenir.
    - Yapay zekâ: OpenAI uyumlu ve Anthropic Claude sağlayıcıları (API anahtarı DPAPI ile şifreli).
    - Tema: tema değişince yazı renkleri özgün renkten yeniden hesaplanır.
    - Dil: etkin pencere 3 sn'de bir yeniden çevrilir; yapay zekâ ayarlıysa eksik metinler arka planda çevrilir.
    - Yayın yalnız depo kökünde YAYIN_ONAYI.txt varken yapılır.
  - Raporlar: kod ve uzak katalog doğrulandı; ekran RAPOR lisans modülü ister. Sorun sürerse hata metni gerekli.
- Testler: kroki AI motoru 8/8 (node), internet paneli 51 + 28, yerel panel geçti. Makine okuyucuları için sahte Modbus, MQTT ve OPC UA sunucularıyla entegrasyon testleri eklendi; .NET derlemesi ve testler CI'da.

## 2.9.1 — stok içinde stok, parça barkodları ve akıllı öneriler (yayımlandı, güncelleme kanalları 18 Kasım 2026'da 2.9.1'e açıldı)

- Stok listesinde 'Parçalar': ürüne parça ve alt parça (10 seviye, döngü engelli) tanımlanır; parçalar barkodlu stok kartıdır, EAN-13 (29…) barkod otomatik üretilir, etiket yazdırılır. Tablo: MPXNext_StokBilesen (Sema.sql, ModullerNext.sql ve çalışma anında idempotent kurulum). HTTPS: StokBilesenServisi.* uçları.
- Üst çubukta '💡 Öneriler': AkilliDenetimServisi 10 dakikada bir salt okunur inceler (stok, üretim, masraf/finans, muhasebe, cari); yalnız yetkili ve lisanslı alanlar. Yapay zekâ bağlıysa 6 saatte bir en fazla 5 fikir ekler.
- CI: 90/90 entegrasyon testi, 40 uzaktan çalışma kontrolü geçti; Android 2.9.1 mevcut yayıncı anahtarıyla imzalı.

## 2.9.0 — çok firma, ayrıntılı sektör kataloğu, bağımsız lisans paneli ve tek düğmeyle bağlantı

- Sektör kataloğu 2: Üretim, Ticaret, Yeme-içme, Hizmet ve diğer grupları altında 23 sektör. Her sektörün davranışı, eski koda karşılığı, alt dalları, birimleri, cari adı ve önerilen modülleri var. C# (UrunKatalogu) ve panel (sectors.js) kataloğu testle eşit tutuluyor.
- Uyumluluk: ERP etkinleştirme isteğinde `catalog=2` gönderir. Eski 2.8.x istemcilere sunucu eski sektör kodunu (BORU/YEDEK/RESTORAN/SUNGER/GENEL) imzalar. Yan PC HTTPS girişinde de aynı kural geçerli.
- Program sektöre göre şekillenir: menü yetkileri, üretim kartı, cari/stok adları ve haber/piyasa kartları `UrunKatalogu.Davranis` üzerinden belirlenir.
- Lisans ekranında "Sektör ve lisans kapsamı" bölümü: grup, açıklama, dallar, birimler, modül bitişleri ve eksik önerilen modüller.
- Mağaza: üstte "Sahip olduğunuz lisans" kartı (modül bitişleri, internetten yenileme). Her paket kartında lisansta açık veya eksik modüller gösterilir.
- Çok firma:
  - Giriş ekranında "Şirket seç". Her şirket ayrı veritabanı ve ayrı lisanstır; profiller `%LOCALAPPDATA%\BoruERP\Sirketler` altında tutulur ve SQL parolası DPAPI ile şifreli kalır. Geçişte program yeniden açılır.
  - Müşteriye özel kurulumda program klasörüne konan `lisans-sunucusu.txt` varsayılan lisans adresini belirler.
- Yerel panel:
  - Parola-Sifirla.cmd
  - sektör seçicisi (gruplu ve ayrıntılı)
  - `LICENSE_CLOUD_ORIGIN` ile internet paneli adresi ayarlanabilir
  - Internete-Esitle.cmd ile tüm lisanslar toplu eşitlenir
- İnternet paneli:
  - `AUTH_MODE=password`: kendi kullanıcı adı/parola girişi, D1 oturumları (göç 0008), hız sınırı, geçici parola akışı. Bu modda oai başlığına güvenilmez.
  - Kendi Cloudflare hesabı için wrangler.toml ve KENDI_SUNUCUNA_TASIMA.md eklendi. İmza anahtarı aynı.
- Bağlantı ekranı sadeleştirildi (PC ve Android): tek "Yapay zekâ ile otomatik bağlan" düğmesi. Sırasıyla bağlantı kodunu (kutu/pano), işyeri ağındaki ana sunucuyu ve kayıtlı adresi dener; DNS + HTTPS + MiaPaxERP servisini doğrular, kaydeder ve bağlanır. Ana sunucuda bağlantı kodunu üretip panoya kopyalar. Başarısızlıkta, tanımlıysa yapay zekâ sunucusundan onaylı açıklama ister (parola/SQL/lisans gönderilmez). Eski seçenekler "Manuel bağlantı" bölümünde.
- Manuel bağlantıda HTTPS adresinin altında ayrı Port kutusu: 443 (varsayılan), 8443 veya 1024–65535 (5188, 5189, 1433, 1434, 3389 hariç). Port bağlantı kodunda taşınır; Android da aynı kuralı kullanır.
- Sürüm 2.9.0 (Android versionCode 20900). Yayın taslağı CI'da oluşturulur; imzalı 2.9.0 APK depoya konmadan yayın adımı durur.
- Testler: yerel panel 62/62 (C# katalog eşitliği dahil), internet paneli 47 + 28 kimlik doğrulama kontrolü. C# dosyaları ayraç/dize dengesi ile denetlendi; .NET derlemesi Visual Studio'da yapılmalı.
- Yayın öncesi: Android 2.9.0 APK'sı mevcut yayıncı anahtarıyla imzalanmalı (Imzala.ps1).

## 17 Kasım 2026 — 2.8.9 sonrası yayımlanmamış kaynak düzeltmeleri

Yeni ERP sürümü veya GitHub yayını yapılmadı. Aşağıdakiler bir sonraki toplu sürümü bekler.

- Mobil "Bekleyen kayıtlar" penceresi gönderilemeyen saha kaydının görüşme notunu ve tarihini göstermiyordu; kayıt kuyrukta duruyordu ancak kullanıcı silmeden önce notu göremiyordu. MiapaxERP.Android/assets/mobile.js artık notu ve tarihi de gösterir. Bu Android varlığı olduğundan 2.8.9 imzalı APK ile CI varlık eşleşmesi bilerek bozulur: değişiklik ancak yeni mobil sürüm numarası, yeniden derleme ve mevcut yayıncı anahtarıyla imzalanmış APK ile yayımlanmalıdır. 2.8.9 kanalına bu kaynakla tekrar yayın yapılmaz.
- MiapaxERP.Tests.MobilWeb/test.mjs 2.8.8 öncesi profil biçimini (yalnız rol) kullandığı için departman yetkili mobil ekranda saha bölümünü göremiyordu. Test, sunucunun gönderdiği departman listesiyle (saha/stok/muhasebe) güncellendi; patron raporu Muhasebe bölümünden, stok bölümü barkod paneli olarak doğrulanır. Yerel koşu: 8/8 tarayıcı senaryosu.
- LisansPanelleri/Web altına Sites checkout ile aynı scripts/build.sh eklendi. Yerel bayi paneli kurulum klasörünün tests dizini çalışma kaynağıyla eşitlendi (yalnız testler; çalışan panel kodu zaten aynıydı).

## 2.8.9 — ilk kurulum, SATIŞ paneli ve güncelleme yeniden açılışı

Yayın: https://github.com/MiaPaxERP/MiapaxERP-Updates/releases/tag/v2.8.9 — kaynak commit f9d7628f50eb755fa0cb5ce3f77ec3a20ba9d85e, imzalı bildirim commit db7d44bca22842921f852977aec21350f32e3670.

- Boş SQL veritabanında ilk kurulum: Admin/1234 yalnız kullanıcı tablosu boşken oluşturulur ve zorunlu güçlü parola değişimi ister; mevcut kullanıcılar değiştirilmez.
- Yetkili ana sayfa başlangıcı, ayrı SATIŞ çalışma paneli (SatisPaneli/SatisModuluServisi/HizliSatisPenceresi normalSatis), üretilen stok görünümü ve depo alış evrakıyla depoya giriş (DogrudanAlis) eklendi; eski stok hareketi CHECK kısıtı IsletmeSemasi ile otomatik yükseltilir.
- Yedekli tam şirket verisi sıfırlama (COPY_ONLY/CHECKSUM + RESTORE VERIFYONLY), tema okunurluğu ve güncelleme sonrası yeniden açılış düzeltmeleri.
- Doğrulama: 86 ERP/HTTPS entegrasyon testi; CI'da HTTPS altyapı, uzak çalışma, e-belge ve güncelleyici kontrolleri; Android DEX/varlıkların imzalı APK ile eşleşmesi; gerçek Ana/Yan setup kurulumu ve 2.8.8→2.8.9 imzalı yükseltme/geri alma.
- Windows masaüstü güncellemesi çalışan ana HTTPS hizmetini değiştirmez; hizmet Ana-Kurulum ile ayrıca güncellenmelidir.

## 2.8.8 — mobil departman, barkod ve uygulama içi güncelleme

Mobil bağlantı asistanı HTTPS alan adını düzenler, sertifika/servis/hesap doğrulaması yapar; DNS, sertifika, erişim ve CGNAT sorunları için açıklama sunar. Mevcut yerel hesabı aynı sunucunun dış HTTPS adresine geçirirken cihaz kimliğini doğrular, başarısızlıkta mevcut bağlantıyı korur. Bekleyen saha kayıtları silinmez. Bu deterministik asistan harici yapay zekâ servisi kullanmaz; modem/DNS hesabına erişimi olmadan bu sistemleri uzaktan yapılandıramaz. Dış HTTPS ana sunucuda hazırlanır, telefon mobil internetinden ayrıca kontrol edilir.

Kullanıcı 17 Kasım'da bekleyen tüm değişikliklerin ana/yan/mobil olarak yayımlanmasına izin verdi; önceki bekletme notlarının yerini bu yayın hazırlığı alır. Ana ve yan Windows ZIP'leri, tam ana HTTPS hizmeti kurulumu, mobil ZIP ve ayrıca imzalı APK ayrı yayımlanır. Ana/yan/mobil güncelleme bildirimleri yalnız başarılı yayın sonrası mevcut Windows yayıncı anahtarıyla imzalanır.

- Kullanıcı Yetkileri'nde Mobil erişim ve departmanları filtresi eklendi. MOBILE.ACCESS ve MOBILE.STOCK/PURCHASE/SALES/PRODUCTION/FINANCE/FIELD/CHAT ayrı seçilir. Mobil departman, normal ERP bölüm yetkisi ve ilgili lisansın kesişimiyle açılır; yönetici mevcut izinleri çalışanlara ayrıca atar. Kullanıcı her mobil API isteğinde yeniden doğrulanır. Yetki geri alınınca bölüm gizlenir. Saha rolü kendi müşteri kapsamını korur; diğer departmanlar kendilerine izinli raporları görür.
- Mobil stok ekranı kamerayla veya elle barkod alır. Kayıtlı üründe ad/kod, özellikler ve stok miktarı açılır. Bulunamazsa yalnız STOCK.CREATE olan kullanıcıya Yeni ürün kaydı oluştur gösterilir. Yeni kart barkodu stok kodu olarak kullanır; miktar veya muhasebe hareketi yaratmaz. Stok tipinin zorunlu özel alanları mobil formda doldurulur ve mevcut stok servisiyle yeniden doğrulanır. Çevrimdışıyken yeni stok oluşturulmaz.
- Kamera izni yalnız tarama açıldığında istenir. Görüntüler kaydedilmez veya sunucuya gönderilmez. Resmî Maven Central ZXing core 3.5.3 SHA256 ile sabitlenmiştir. Kod çözücü gerçek uygulamayla aynı Java sınıfıdır; CODE128 (baştaki sıfırlar), EAN13 ve QR, yatay/döndürülmüş NV21 kareler ve boş görüntüyle test edildi. Fiziksel Android telefon/kamera bağlı olmadığından cihaz üzerindeki kamera ve kurulum arayüzü kabul testi bu ortamda yapılamadı.
- Uygulamayı güncelle düğmesi imzalı Mobil bildirimi okur; yayıncı RSA-PSS imzası, HTTPS kaynak sınırı, SHA256, paket adı, sürüm ve mevcut Android imza sertifikası denetlenir. APK özel önbelleğe indirilir, dar kapsamlı ContentProvider ile yalnız Android kurucusuna verilir. Android izin/kurulum onayını kullanıcı verir; sessiz kurulum veya sertifika atlatma yoktur. Eski mobil sürümde güncelleme düğmesi olmadığından 2.8.8 imzalı APK bir defa kurulmalıdır; sonraki yayınlarda düğme kullanılır.
- Mobil mesajlaşma, yetkili kullanıcı/departman konuşmaları ve kişisel bildirim kutusu eklendi. Önceki lisans paneli duyurusu, iletişim başlangıcı, sıkı ana sayfa/takvim yetkileri ve stok/paket etiket değişiklikleri bu yayına dahildir.
- Yeni mobil istemciyi kullanmadan önce ana HTTPS hizmetini Ana-Kurulum ile aynı sürüme getirin. Windows masaüstü güncelleyicisi çalışan ana hizmeti değiştirmez. Yeni mobil izinler tanımlanmadan çalışan mobil hesabı açılmaz; bu istenen ayrı erişim sınırıdır.
- Yerel doğrulama: 75 ERP entegrasyon testi, 20 gerçek Java bağlantı/barkod/güncelleme kontrolü geçti. APK aynı mevcut Android yayıncı anahtarıyla v2/v3 imzalandı. Tam çözüm Release derlemesi hatasızdır. GitHub aynı testleri ve imzalı APK'nin taze DEX/varlık eşleşmesini tekrar doğrular.

## 17 Kasım 2026 — lisans panelinden şirket duyuruları ve tam ekran yetkileri

Yeni ERP sürümü/GitHub yayını yapılmadı. İnternet ve yerel lisans paneline Müşterilere duyuru bölümü uygulandı; ERP'de alım ve sıkı görünürlük kodu sonraki toplu güncellemeyi bekliyor. Eski 2.8.7 müşterileri duyuruyu henüz bildirim kutusuna aktaramaz; panelde yayımlanan kayıt kuyrukta kalır.

- Yalnız panel OWNER/yetkili internet yöneticisi tek müşteri veya gönderim anındaki tüm etkin müşterileri hedefleyebilir. Hedef şirket listesi yayımlama anında sabittir; sonradan açılan müşterilere eski duyuru taşınmaz. Önizleme sonrası gönderim gerekir; aynı işlem kimliği tekrarı çoğaltılmaz. Gerçek müşteriye test duyurusu gönderilmedi.
- 0006_announcements sadece eklemeli şemadır. Duyurular müşterinin lisansıyla ilişkilidir ve RSA-PSS imzalı lisans yanıtında toplam 9 KB sınırıyla sayfalı gönderilir. İstemcinin verdiği müşteri kimliği hedefi değiştirmez. Mevcut 24 KB lisans zarfı ve eski istemci doğrulaması korunur.
- Ana ERP/HTTPS hizmeti imzayı ve cihaz/veritabanı bağını doğruladıktan sonra duyuruyu işlem içinde kendi şirketindeki aktif kullanıcıların kişisel bildirimlerine aktarır. Kaynak/şirket/duyuru anahtarı yinelenmeyi önler. Okundu durumları kişiseldir. Teslim imleci ancak SQL işlemi başarılı olduğunda şifreli önbelleğe ilerletilir. Yan cihaz bildirimleri mevcut HTTPS servisiyle alır.
- DASHBOARD.VIEW ana sayfa için; CALENDAR.VIEW takvim için; ASSISTANT.VIEW asistan için; DATA.VIEW Excel/yazdırma araçları için ayrı atanır. Başka modül izni ana sayfa veya finans menüsünü açmaz. Cari/satış/rapor kendi yetkileriyle erişilir; yetkisiz ana sayfaya otomatik dönüş kaldırılmıştır. Yetki kaldırılınca açık ekran kapatılır, görünür yetkili menüye yönlenilir; hiç izin yoksa boş ve açıklamalı çalışma alanı kalır.
- Ana sayfa kısayolları ve muhasebe alt gezinmesi de yetkisiz bölümleri gizler. Profil/çıkış ve kişinin kendi bildirim kutusu temel oturum işlevleri olarak korunur. Mevcut izin atamaları otomatik genişletilmez.
- 71 ERP entegrasyonu, 44 yerel panel testi, 42 web paneli temel kontrolü ve imzalı şirket duyurusu uçtan uca kontrolü geçti. Release çözümü 0 uyarı/0 hata. Tarayıcıda bellek içi TEST şirketine önizle/gönder/geçmiş akışı doğrulandı.

## 17 Kasım 2026 — panel kurulumu ve iletişim açılış düzeltmesi

Kullanıcı yeni ERP sürümü yayımlanmamasını istedi. 2.8.7 GitHub yayını ve güncelleme bildirimleri bu işlemde değiştirilmedi.

Yerel lisans paneline daha önce yalnız kaynak paketinde bırakılan modül tarihleri ve 15 saniyelik destek penceresi yenilemesi uygulandı; SQLite yedeği, mevcut müşteri/lisans/cihaz kayıt sayıları ve bütünlük kontrolü doğrulandı. Eski OWNER hesap adındaki BoruERP/MiaSoft görünür marka metni API'de MiaPaxERP olarak sunulur; giriş adı ve saklanan kimlik değiştirilmez. İnternet lisans paneli aynı Site kimliği ve erişim politikasıyla güncellendi; 0005_module_dates geçişi eklenmiştir. Aktif lisansların tarihleri kullanıcı tarafından tanımlanmalıdır; bilinmeyen geçmiş süreler uydurulmaz.

Çalışan ERP'de bildirim düğmesinde dbo.MPXNext_Duyuru bulunamadı hatası gözlendi. İletişim kurulumu yalnız USERS.MANAGE olan kullanıcının ilk girişine bağlandığından ilk muhasebe/stok kullanıcısında pencereler boş kalıyordu. Yerel BoruERP veritabanı COPY_ONLY/CHECKSUM yedeklendi ve RESTORE VERIFYONLY geçti; sabit, eklemeli iletişim geçişi işlem içinde uygulandı. Mevcut kullanıcı izinleri, stok ve muhasebe hareketleri değiştirilmedi.

Sonraki toplu güncelleme için kaynakta: etkin kimliği doğrulanan herhangi bir kullanıcının ilk iletişim bağlantısı aynı sabit şemayı uygulayabilir. Uygulama kilidi eşzamanlı ilk açılışları sıralar; kullanıcıya yönetici yetkisi verilmez. Yetkisiz/pasif kullanıcı kurulum başlatamaz. İletişim penceresi yükleniyor/başarısızlık/yetki durumunu gösterir ve yeniden deneme sunar. Konuşma alıcısı seçiminde sadece üye olunan departmanlar gösterilir; duyuru yönetimindeki daha geniş liste korunur. Bu yeni WPF/başlangıç kodu kurulu EXE'ye kopyalanmadı; sonraki toplu güncellemede dağıtılacak. Canlı veritabanı düzeltmesi mevcut 2.8.7 ile çalışır; izinler için Admin Kullanıcı ve Yetkiler'den CHAT.VIEW/CHAT.SEND atamalıdır.

Doğrulama: 62/62 ERP entegrasyonu, yönetici olmayan iki kullanıcının eşzamanlı ilk açılışı, pasif kullanıcı engeli ve değişmeyen yönetici izinleri dahil geçti. Yerel panel 42/42 test geçti; web paneli 42 temel kontrol ve destek/modül süresi kontrolleri geçti. Release çözümü 0 uyarı/0 hata. WPF iletişim ekranı TEST verisiyle çizdirildi; gerçek müşteri mesajı gönderilmedi.

## 2.8.7 yayın hazırlığı — stok ve paket etiketleri

Stok kartındaki Barkodlar ekranından kayıtlı ürün barkodu/çarpanı ile etiket yazdırılır. Üretim emrindeki Paket barkod etiketi düğmesi kayıtlı paketleme partisini, paket içi adedi, özellikleri ve üretim emrini getirir. Ölçü mm olarak 100x100 gibi girilir; içerik ölçüye otomatik sığar. Kâğıt ölçüsü Windows yazıcı sürücüsüne gönderilir; sürücü ölçüyü değiştirirse veya yazdırılabilir kenar alanı uygun değilse işlem durur. Barkod fiziksel olarak fazla küçülüyorsa daha büyük etiket istenir; sessiz ölçekleme yapılmaz.

Paket kimliği MPXPK + paketleme kayıt kimliği + sıra numarasıdır; tekrar yazdırmada değişmez. Hızlı satış paketin kayıtlı iç adedini getirir; iptal üretim ve paket sıra sınırı dışı barkodlar reddedilir. Bu özellik fiziksel paketin bir kez satıldığını izleyen ayrı seri numarası satış defteri değildir. Yazdırmak stok veya üretim miktarını değiştirmez. STOCK.VIEW veya PRODUCTION.VIEW sunucu yetkisi zorunludur; yan bilgisayar veri için HTTPS, yazdırmak için kendi Windows yazıcısını kullanır.

Son yerel doğrulama: 62/62 ERP entegrasyon testi, 0 atlanan; tam Release derlemesi 0 uyarı/0 hata. 100x100 etiketler 203 DPI'da çizildi ve gerçek Code128 çözücüyle tekrar okundu. İzole SQL üzerinde paket içi miktar, sıra sınırı, iptal üretim ve yetkisiz okuma kontrol edildi. Fiziksel termal yazıcı bu çalışma ortamında denenmedi.

Android 2.8.7 yerelde derlendi; mevcut Android yayıncı sertifikasıyla v2/v3 imzası doğrulandı. Yeni anahtar oluşturulmadı. GitHub akışı imzalı APK'nin sertifikasını ve taze derlemenin DEX içeriğini ayrıca doğrular. Ana/Yan otomatik güncelleme bildirimi yalnız yayın dosyaları doğrulandıktan sonra mevcut Windows yayıncı anahtarıyla imzalanır. Aşağıdaki yayımlanmamış notları bu sürümün kapsamını açıklar; canlı lisans paneli kurulumu ayrıca gerekir.

## 16 Kasım 2026 — toplu güncelleme için yerel, yayımlanmamış çalışma

Bu bölüm aşağıdaki eski yayın notlarından daha yenidir. Kurulu 2.8.6, canlı müşteri veritabanı, çalışan HTTPS hizmeti, yerel lisans paneli ve internet lisans paneli değiştirilmedi. GitHub yayını ve otomatik güncelleme bildirimi oluşturulmadı.

- Her iki lisans panelinin görünür markası MiaPaxERP olarak düzenlendi. Cihaz donanımı her kalp atışında güncellenir; ERP bildirimi 1 dakika, açık destek penceresinin yenilenmesi 15 saniyedir. Yeni hata tekrarları çözülmüş kaydı yeniden açar. Eski istemcilerin alanları doldurması için istemci güncellemesi de gerekir.
- Modül bazında bitiş tarihleri lisans imzasına dahildir. Tarihler ana lisansın süresiyle ve modül bağımlılıklarıyla denetlenir. Son 7 günde Admin'in kişisel bildirim kutusuna tekilleştirilmiş uyarı düşer; süresi dolan modül kapanır. Eski lisanslar tarih alanı olmadan çalışır.
- Ana sayfada boru/sulama, Türkiye ve dünya RSS başlıkları dönüşümlü gösterilir. Haberler 60 saniyede yenilenir. İlk yüklemedeki eski başlıklar uyarılmaz; yeni ve yakın tarihli son dakika başlığı kullanıcı başına bir kere üst bantta görünür.
- Yerel ağda HTTPS ana sunucu keşfi eklenmiştir. Yan bilgisayar SQL'e doğrudan bağlanmaz. Keşif sonrası gerçek TLS kontrolü yapılır; yeni adres normal bağlantı düğmesiyle kabul edilir. Farklı kayıtlı sunucu sessizce değiştirilmez. Alan adı, güvenilir sertifika ve modem yönlendirmesi ana sunucuda bir defa kurulmalıdır; ISP dış IP hizmeti program tarafından değiştirilemez.
- Stok kartında birden fazla barkod ve miktar çarpanı bulunur. Hızlı satış mevcut atomik satış/stok/cari/muhasebe/tahsilat servisini kullanır; bağlantı tekrarında aynı işlem ikinci kez stoktan düşmez. TRY dışındaki satışlar mevcut ticari satış ekranındadır.
- Seçilen üretim emri ve paketleme kayıtları PDF olarak alınır. Ayrıntılı maliyet tablosu gerçek hammadde partisi, makine süresi, işçilik, elektrik, fire ve bağlı sevkiyat dayanaklarını gösterir. Eksik maliyet sıfır sayılmaz; kullanıcı navlun/genel gider paylarını belgeye dayalı düzenler. Düzenlemeler sürüm ve revizyon kaydıyla tutulur; analiz otomatik muhasebe fişi oluşturmaz. MRP mevcut reçete ve net ihtiyaç hesabını kullanır; genel çok seviyeli BOM planlayıcısı değildir.
- Günlük maliyet raporu aktif Admin ve yetkili muhasebe alıcılarına tekilleştirilerek gönderilir. Ana hizmet çalışırken veya yetkili ERP oturumu açıkken günlük görev yürür. Hizmet kapalıyken işletim sistemi zamanlayıcısı gibi çalıştığı iddiası yoktur.
- Departman/kişi bazında duyuru ve mesajlaşma eklendi. Alıcı ve departman üyeliği sunucuda denetlenir. HTTPS uzun bekleme bağlantısı yeni mesajı bildirir; pencere 2 saniyelik yedek yenileme kullanır. Oturum kapanınca özel pencereler kapatılır.

### Kurulum sırası ve yetkiler

1. Her iki lisans panelinde 0005_module_dates.sql geçişi uygulanmalı; güncel panel kaynakları kurulmalıdır. Eski kriptografik türetme sabitleri ve veri dizini adları uyumluluk için korunmuştur.
2. ERP ana sunucu ve yan bilgisayarlar aynı derlemeden güncellenmelidir. İlk Admin oturumunda ModullerNext.sql kontrollü ve işlem içinde uygulanır; USERS.MANAGE gerekir. Yeni izinler mevcut kullanıcılara kendiliğinden genişletilmez.
3. Kullanıcı ve Yetkiler'den QUICKSALE.VIEW + SALES.VIEW, COST.VIEW/EDIT/PUBLISH, CHAT.VIEW/SEND ve NOTIFICATION.PUBLISH uygun kişilere atanmalıdır. Maliyet bildirimlerinin muhasebe alıcısında COST.VIEW + ACCOUNTING.VIEW gerekir. Departman üyeleri Admin tarafından tanımlanır.
4. Yapay zekâ ekranı mevcut Ollama/MiaPax bağlantısını kullanır. Bu çalışmada model kurulmadı ve canlı model yanıtı test edilmedi. Otomatik aritmetik, net ihtiyaç hesabı, ağ keşfi ve yetki denetimi model olmadan çalışır. Müşteri verisi analize gönderilmeden kullanıcı onayı gerekir.

### Son doğrulama

- Tam Release çözüm derlemesi: 0 hata; NuGet güvenlik denetim adresine erişim nedeniyle 2 NU1900 uyarısı.
- ERP HTTPS entegrasyonu: 52 geçti, 0 başarısız, 0 atlanan. İzole SQL işlemleri, gerçek HTTP oturumu/uzun bekleme, 3 ardışık UDP keşfi, barkod, hızlı satış tekrar koruması, maliyet eksikleri ve revizyon, bildirim alıcı yetkileri dahildir.
- Yerel Node lisans paneli: 41 geçti. Web lisans paneli: 42 temel kontrol + destek/donanım/modül süresi + posta şifreleme kontrolü geçti; yerel Worker derlemesi ve artefakt doğrulaması geçti. Gerçek e-posta gönderilmedi.
- Tarayıcıda TEST müşteri cihaz/sorun penceresinin otomatik yenilenmesi gözlendi. ERP'nin kendi WPF bileşenleri sentetik verilerle çizdirildi; gerçek PDF yazıcısıyla üretim/paketleme PDF'leri oluşturulup görsel kontrol edildi. Kullanıcının açık uygulamalarında tam tıklama testi yapılamadı; gerçek müşteri verisiyle kabul testi yerine geçtiği iddiası yoktur.
- Çıktılar çalışma alanının outputs/next-native ve outputs/next-tests klasörlerindedir. Güncel kaynak arşivi ve durum kaydı ayrı saklanır; arşiv kurulum paketi değildir.

2.8.3 kaynak ve Windows x64 paket yayını. Ana dal yayını aynı SQL/TLS doğrulamasını tekrar çalıştırır ve başarılı olursa GitHub Releases paketini oluşturur. Otomatik güncelleme için masaüstü dosyaları ZIP kökünde paketlenir. Ana/Yan bildirimleri paket yüklemesinden sonra mevcut yayıncı anahtarıyla imzalanır. Uzak masaüstü kullanılmaz.

## Bu kopyadaki değişiklikler

- HTTPS oturumu, sunucuda kimlik/yetki denetimi ve imzaları açıkça tanımlanmış işlem kataloğu. Uzak masaüstü kullanılmaz.
- Eski stok, üretim, cari, finans, laboratuvar ve yardımcı ekran işlemlerinin sunucu servislerine taşınması; sabit sorgu kimlikleriyle salt okuma köprüsü.
- Satışın stok, cari, muhasebe ve girilmiş tahsilatla aynı işlemde kaydedilmesi; dövizli satış/tahsilat kur farkı.
- Sipariş–mal kabul–alış faturası miktar, fiyat ve KDV eşleştirme işlemleri.
- Depo/raf, parti, rezervasyon, transfer, sayım, üretimde hammadde–mamul parti bağlantıları.
- Dengeli muhasebe fişi, yevmiye, mizan ve aylık dönem kilidi. Kesin fiş değiştirilmez; ters fiş kullanılır. Resmî e-defter onayı iddiası yoktur.
- Sevkiyat/kantar ve boru basınç testi ekranları; fotoğraf/video arşivi, ayrı teknik inceleme, PDF raporu.
- Menü arama ve konum işareti; laboratuvar/kalibrasyon PDF arşivi.
- Makine kapasitesi, reçete/hedef KG üzerinden malzeme ihtiyaç hesabı ve fiilî maliyet kayıtları.
- Hızlı Bilişim, web sitesi, mağaza ve mobil hesap yönetimi için HTTPS sunucu adaptörleri. Sağlayıcı sonuçlarını istemcinin yazabildiği uçlar yayımlanmaz.

## Doğrulama ve kurulum sınırları

- GitHub Windows koşusu 43377312600: 20/20 test geçti, atlanan test yok; tam çözüm 0 uyarı / 0 hata.
- Gerçek TLS oturumu, güvenilmeyen sertifikanın ve yanlış alan adının reddi doğrulandı. Gerçek şifreli SQL bağlantısı geçti.
- İzole veritabanında satış/stok/cari/tahsilat, kısmi döviz ödeme yuvarlaması, geri alma, depo/rezervasyon/sayım değerlemesi, sipariş–kabul–fatura, parti izi, kapasite, fiilî maliyet, dönem kilidi ve bağımsız basınç onayı doğrulandı.
- 163 sabit okuma sorgusu ve kayıtlı HTTPS servis yolları denetlenir. Bu, bütün ekranların müşterinin verisiyle elle denenmiş olduğu iddiası değildir.
- Son mobil yan cihaz koruması, basınç tekrar kaydı ve paketleme de yayın öncesi aynı CI'da tekrar doğrulanır.
- İlk şifre/kurtarma, Excel ve yönetici sıfırlama sunucu akışları kodda mevcuttur; müşterinin gerçek hesap/verileriyle kabul denemesi gerekir.
- MRP boru üretiminin yüzdeli reçete/hedef KG yapısına dayanır; genel çok seviyeli BOM planlayıcısı değildir.
- Hızlı Bilişim hesabı/GİB gerçek gönderimi, mağaza sağlayıcıları ve müşterinin alan adı/modem bağlantısı bu testlerde kullanılmadı. Gerçek anahtarlar müşteri ana sunucusunda girilmelidir.
- Yeni Android APK imzalanmadı. Mevcut imzalı APK HTTPS adresi ve kişisel eşleme koduyla kullanılır; yeni bağlantı kodu desteği kaynakta bulunur.
- Canlı D: kurulumu ve müşteri veritabanı bu kaynak yayını tarafından değiştirilmedi.
- Basınç testi reddedilen parti güvenlik gereği serbest bırakılamaz. Yeniden işleme/teknik uygunsuzluk süreci işletilmeden geçmiş ret yok sayılmaz.

## Elle kurulum

Önce SQL veritabanını ve mevcut kurulum klasörünü yedekleyin. Windows x64 paketini ayrı klasöre açın. Ana bilgisayarda Kolay-Kurulum.cmd ile HTTPS sunucusunu yapılandırın; alan adı ve modem 443 yönlendirmesi ana sunucuya ait olmalıdır. Yan bilgisayarda Masaustu/MiapaxERP.Desktop.exe içindeki bağlantı ekranında HTTPS ana sunucu adresini seçin. SQL portunu internete açmayın. Mevcut lisans ve kullanıcı yetkileri geçerlidir. Yeni modüllerin kurulum işlemi MODULES.INSTALL yetkisi ister. Ana sunucu ve yan cihazların sürümü aynı olmalıdır.

## Derleme ve test

Windows ve .NET 10 SDK ile `MiapaxERP.slnx` çözümünü açın. Yeni test projesi `MiapaxERP.Tests.HTTPS.Integration` klasöründedir. Gerçek bağlantı testlerini çalıştırmadan önce ortamı hazırlayın; geliştirme kaydını üretim kurulumu olarak kullanmayın.

Sunucu anahtarları, şifreli hesap dosyaları, veritabanı dosyaları ve derleme çıktıları kaynak yayınına dahil edilmez.
Boyutu büyük tanıtım videoları, GeoJSON harita verileri ve places.json veri dosyaları bu hızlı kaynak yayınına eklenmedi; mevcut kurulumdaki bu varlıklar kaynak yayınından bağımsızdır.

## 2.8.3 arayüz ve güncelleme düzeltmeleri

Yeni sekiz modül ana ekran içinde açılır; mevcut menü stilini ve seçili temayı kullanır. Depo raf ağacı, muhasebe dönem/mizanı, satın alma satır eşleştirmesi, basınç ölçümleri, sevkiyat rotası, dövizli tahsilat özeti, makine planları ve MRP/maliyet ayrı çalışma alanlarıdır.
Girişteki MiaPaxERP logosu korunur. Stok–üretim–sevkiyat–finans akışını gösteren sessiz çizim animasyonu eklenir; pencere gizlendiğinde durur ve Windows hareket azaltma ayarına uyar.
Bilinen eski BoruERP güncelleme adresi mevcut MiaPaxERP kanalına taşınır; özel sunucu adresleri korunur. Yeni sürüm dosya sürümü 2.8.3.0'dır. Güncelleme paketi mevcut RSA-PSS anahtarıyla doğrulanır; anahtar değiştirilmez.

## 2.8.4 müşteri destek bilgileri
Cihaz sayısı, ana/yan PC Windows, işlemci, RAM ve sabit disk bilgileri ile sınıflandırılmış hata kayıtları lisans sunucusuna bildirilir. Parola, lisans anahtarı, SQL metni ve müşteri belge içeriği hata kayıtlarına eklenmez. Eski istemcilerden henüz bilgi gelmeyen alanlar boş gösterilir. Yan PC bildirimleri yetkili HTTPS oturumuyla ana sunucu üzerinden iletilir. İlgili lisans sunucusu da destek güncellemesini almalıdır.

## 2.8.5 kroki ve güncelleme
Parsel PDF sayfaları yerel PDF.js ile zemin olarak açılır; iki noktadan ölçeklenir. PDF koordinat veya kadastro sınırı olarak otomatik yorumlanmaz; sınır çizimi ve harita referansı kullanıcı tarafından doğrulanır. Sulama hatları ve başlıklar seçilen yön/aralıkta hizalanır; sınır dışına taşacak parçalar korunur. Kaynak noktası ve debi/basınç alanları mevcut akışla kullanılır. Google uydu ve 3D arazi için kullanıcının Google Cloud Maps anahtarı, faturalandırma ve koordinat referansı gerekir. Anahtar girilmediği için Google canlı harita kabul testi yapılmadı.
Ana/Yan güncelleme ZIP dosyaları ayrıdır; eski güncelleyicinin reddettiği Lisans.Core.pdb ve kullanıcı ayar dosyaları paketlere alınmaz. Son kullanıcıda açık olan Debug kopyası otomatik güncellenmez; Release kurulumu kullanılmalıdır. Mobil ZIP içindeki APK imzasızdır; mevcut Android anahtarıyla normal Windows oturumunda Imzala.ps1 çalıştırılmadan müşteriye dağıtılamaz. Ana HTTPS Windows hizmeti ayrı tam Ana-Kurulum paketinden güncellenir; masaüstü otomatik güncelleme çalışan hizmet dosyalarını değiştirmez.

## 2.8.6 anahtarsız harita saha sayaçları ve menü yetkileri
Kroki anahtarsız OpenStreetMap internet haritasını varsayılan açar; sulama hatları aynı koordinat dönüşümüyle haritada gösterilir. Saha Türkiye haritasında her il için kayıtlı kişi kartı sayısı görünür; tekrar görüşmeler sayıyı artırmaz. İl seçimi solda görüşme notu olmayan kartlar dahil tüm kayıtları sayfalı ve kaydırarak gösterir; mevcut mobil sahiplik kapsamı korunur. Menü modülleri oturum kullanıcısının etkin izinleri ve lisansı birlikte değerlendirilerek gizlenir; tema ve lisans yenilemesi görünürlüğü geri açmaz. Kullanıcı yönetiminde KROKI.VIEW ayrı atanabilir. Üretim stok tüketimi emrin ilk kaydında değil üretim tamamlanıp stok işleme aşamasında gerçekleşen miktar ve fire üzerinden yapılır; bu zamanlama değiştirilmedi.

## 17 Kasım 2026 — yerel panelde cihaz bilgilerinin boş kalması düzeltildi

ERP raporları varsayılan internet lisans sunucusuna gönderiyordu; yerel panel üç etkinleştirme kaydına rağmen kendi support_devices tablosunda sıfır rapor içeriyordu. İnternet panelinde gerçek cihazın 2.8.8.0 raporu mevcuttu. Yerel destek okumasına isteğe bağlı SUPPORT_CLOUD_ENABLED=true eklendi; mevcut yayıncı RSA-PSS imzasıyla yalnız aynı lisans ID ve anahtar özeti eşleşen kayıtlar internet panelinden okunur. Anahtar tarayıcıya verilmez; özel anahtar mevcut DPAPI ayarında kalır. İstekler bir dakika süreli ve hedef HTTPS adresi sabittir. Yerel kullanıcı/bayi müşteri kapsamı uzaktan okumadan önce doğrulanır. Son bilgiler bağlantı hatasında korunur, kaynak/hata mesajı görünür. Sorun çözme işlemi aynı yetkilendirmeyle kaynağa aktarılır. Yeni müşteri/lisans/aktivasyon oluşturulmaz.

49 yerel panel testi geçti. İnternet paneli kaynak commit 6bd34896eb3534562813819c07346efdc3d09852, sürüm 13 canlıya alındı. Yerel panel kurulup gizli DPAPI yapılandırmasında eşitleme açıldı. Gerçek ALi kaydında Windows/CPU/RAM/disk/sürüm ve sorunlar, Yenile işlemiyle tarayıcıda doğrulandı. ERP dosyaları veya GitHub sürümü değiştirilmedi; panel düzeltmesi canlıdır.

## 17 Kasım 2026 — ilk açılışta Satış Operasyonları yerine yetkili ana sayfa

YetkiliEkranaYonlendir menüdeki ilk görünür düğmeyi seçiyordu; dinamik satış düğmesi Ana Sayfa önüne geldiği için yönetici ilk açılışta satış tablosunu görüyordu. Başlangıç seçimi artık DASHBOARD.VIEW varsa görünür/etkin Ana Sayfa düğmesine öncelik verir; yetki yoksa ilk diğer yetkili ekranı seçer. Gizli/etkisiz düğmeye geçmez, yetkisiz ana sayfaya geri dönmez. Ana sayfa mevcut açma işlemiyle arka planı ve içeriği birlikte görünür yapar. 24 başlangıç/menü yetkisi kontrolü geçti; win-x64 Release yayını hazır. Yeni GitHub sürümü yayımlanmadı. Açık ERP zorla kapatılmadan yerel düzeltmenin kurulması kullanıcıya sunuldu.

## 17 Kasım 2026 — SolidPlast yerel lisansının internet otoritesine aktarımı

Yerel panelde etkin ve süresiz olan iki SolidPlast lisansı varsayılan internet otoritesinde bulunmuyordu. Anahtarlar değiştirilmeden kayıtlar yayıncı imzalı snapshot ile aktarıldı ve uzaktan okuma doğrulandı. İnternet paneli Sites sürüm 14, kaynak commit 97955f2e43b6463d5a2a214de9971d777f32fefa canlıdır. Yerel panelde lisans/müşteri düzenleme, yeni kayıt, anahtar yenileme ve hak atamadan sonra otomatik aktarım; hata kuyruğu ve OWNER İnternete eşitle düğmesi kuruldu. Bu tam çift yönlü portal replikasyonu değildir. 55 Node testi geçti.

İstemci kaynakta artık süresi biten çevrimdışı belgenin saklı anahtarını silmeden sunucuya yenileme sorar; açıkça girilen yeni anahtar ağ hatasında eski belgeyle başarılı sayılmaz. Doğrulama yetki/süre hatası açılışı çökertmek yerine lisans ekranında kalır. İlgili başlangıç/yetki/yenileme test grubu 26 kontrol geçti. Bu istemci değişikliği henüz yeni GitHub sürümüne veya kurulu uygulamaya dağıtılmadı. SolidPlast müşteri bilgisayarında son kabul sonucu bekleniyor.

2026-11-17 — YAYIMLANMAMIŞ KURULUM / SATIŞ GÜNCELLEMESİ
Kullanıcı talimatı: GitHub, güncelleme akışı ve lisans sitesi için yayın yapılmayacak. 2.8.8 sürüm numarası korunuyor; oluşturulan setup adları ONIZLEME taşır. Yayın günü yeni sürüm numarası tüm kanallarda ayrıca hazırlanmalı.
- Setup/MiaPaxERP.iss ve Build-Setup.ps1: Ana/Yan ayrı EXE; .NET dahil, SQL Server motoru ve müşteri verileri hariç. Mevcut bağlantı/lisans ve yapılandırmalar korunur. Ana paket HTTPS sunucusunu ve servis kurulum araçlarını içerir; hizmet/modem ayarı kendiliğinden değiştirilmez. Yan kısayolu --baglanti kullanır ve ilk SQL sihirbazına yönlenmez.
- İlk kurulum: Admin/1234 yalnız sihirbazı açar. Windows veya SQL kimliğiyle boş şirket DB/schema/izin kataloğu hazırlanır. Şema yalnız DDL ve ürün izin kataloğudur, müşteri satırları içermez. Lisans doğrulaması korunur; ilk gerçek Admin girişi parola değişimi ister. Mevcut Admin parolası sıfırlanmaz.
- Ana sayfa önceliği korunur; kullanıcıya yalnız yetkili başlangıç ekranı gösterilir. Eski müşteri paketlerinde bulunmayan başlangıç düzeltmesi yeni setuplara dahildir.
- SATIŞ: cari/perakende, barkod/kod/ad arama, normal ve üretilen stok, 0..20 KDV listesi ve elle ondalık oran. Aynı işlemde stok/parti/cari/muhasebe ve seçilirse tahsilat. Yetersiz stok veya maliyet eksikliğinde tam geri alma. TRY ekranı; dövizli belgeler mevcut ticari ekranda.
- Üretilen stok görünümü aynı stok defterinin üretimden kalan alt miktarıdır; iki defa stok oluşturulmaz. Bloke ve rezervasyon kontrolü korunur.
- Eski gerçek şemadaki hareket tipi/yön kısıtları SATIS, MAL_KABUL, SAYIM için kontrollü genişletildi. Testler gerçek boş şemada yürütüldü.
- Tam sıfırlama yalnız yönetici + mevcut parola + DB adı + açık onay ile; önce SQL COPY_ONLY/CHECKSUM yedeği ve RESTORE VERIFYONLY, sonra tek işlemde ERP tablolarını temizleme. SQL yedek yetkisi gerekir. Admin/1234 yeniden oluşturulur, değişim zorunlu. Identity sayacı düşürülmez. Bağlantı/lisans, fiziksel dosya arşivleri ve sıfırlama yedek kaydı saklanır. Gerçek şirket veritabanında çalıştırılmadı.
- Tema: düz renk yüzeylerde en az 4.5 metin kontrastı; yeni açılan pencereler, tablo hücreleri ve seçili satırlar için yeniden uygulanır. Koyu temada onay kutusu yüzeyi ayrıca düzeltildi. 12 temanın renkleri otomatik, açık/koyu ilk kurulum ve satış görselleri yerel render ile kontrol edildi.
Doğrulama: 86 ERP/HTTPS testi geçti. HTTPS altyapı 832 kontrol ve 40 uzak çalışma kontrolü, gerçek TLS başarılı/yanlış isim/güvenilmeyen sertifika senaryoları geçti. Ana ve Yan preview setup kurulumu, yükseltmede ayar korunması, payload/hashing ve kaldırma testleri çalışma klasöründe yapıldı. Fiziksel müşteri PC'sinde/SQL kullanıcı parolasıyla canlı kurulum testi yapılmadı; Windows SQL kimliğiyle ayrı geçici DB'ler kullanıldı.
Yerel çıktılar: outputs/Kurulum-Onizleme (setups, SHA256, test TRX, kurulum logları ve UI QA). Bu turda mevcut kurulu ERP EXE/DLL dosyaları değiştirilmedi ve yayın yapılmadı.

2026-11-17 — 2.8.9 YAYIN ADAYI
Kullanıcı yeni sürümün Ana/Yan Setup EXE ve mobil dahil yayımlanmasını açıkça istedi; önceki yayınlamama talimatını bu sürüm için değiştirdi.
Satın alma: Depo ve SATIN ALMA ekranlarında alış evrakı ile doğrudan mal kabul. Tek transaction ile sipariş/mal kabul, parti/raf, stok bakiyesi ve stok hareketi. Aynı tedarikçi+evrak numarası veya işlem kimliği tekrar işlenmez. Hatalı satır tüm kaydı geri alır. Normal sipariş/mal kabul/fatura eşleştirmesiyle aynı kayıtlar kullanılır, faturada stok ikinci kez artmaz. Depo kullanıcısı için WAREHOUSE.VIEW, STOCK.RECEIVE; seçim listeleri STOCK.VIEW, CUSTOMER.VIEW ister. Muhasebe kaydı için ayrı alış faturası eşleştirme yetkisi gerekir.
Güncelleme: Kullanıcının eski loglarında hem başarılı 2.8.8 hem geçmiş dosya kilidi/eksik updater hataları vardı; müşterinin makinesindeki kesin neden görülmedi. Yeni akış manuel onayla programı kapatır ve updater başarıdan sonra yeniden açar. Açılışta bekleyen imzalı paket için kurulum seçeneği, başarısızlıkta hata gösterimi var. Çalışan updater üzerine kopyalamak yerine her işlem ayrı worker klasöründen başlar. Eşzamanlı updater mutex kilidini bekler. Eski sürümde bu düzeltme yoksa ilgili 2.8.9 Setup mevcut ERP EXE klasörüne kurulmalıdır.
Setuplar: Desktop dosyaları doğrudan seçilen klasöre kurulur; eski Masaustu klasörü seçilince ikinci Masaustu alt klasörü oluşturulmaz. Ana ve Yan taze kurulumlarında doğru update kanalı yazılır; eski kanal dosyaları korunur. SQL Server motoru ve müşteri verileri dahil edilmez. HTTPS sunucusu Ana setup içindedir; çalışmakta olan Windows hizmetinin sürümü kendi servis kurulum aracıyla ayrıca güncellenir.
Mobil 2.8.9: mevcut uygulama kimliği ve yayıncı anahtarı korundu; sürüm kodu 20809. Bu turda mobil işlev değiştirilmedi, sunucuyla aynı sürüm olarak yeniden paketlendi.
Test: 86 ERP/HTTPS kontrolü geçti; yeni alış evrakı, toplam/raf/parti artışı, tekrar evrak ve ikinci satır hatasında rollback bu gerçek SQL testinde doğrulandı. Güncelleyicinin kurulum, rollback, imza/SHA/kanal/yol kontrolü, mutex bekleme, başarıda restart ve hata bilgisini koruyan restart dahil 30 testi geçti. Gerçek müşterinin bilgisayarında test yapılmadı.

Son yayın kontrolü: Tam sıfırlamada yalnız yabancı anahtarlar geçici kapatılır; satır CHECK denetimleri açık tutulur. Kontrol testi sys.check_constraints durumunu da doğrular. GitHub derlemesi ana kaynak + patch + MiaPaxERP-fix.zip sırasıyla hazırlanır. Son doğrulanmış aday, henüz etkinleştirilmemiş 2.8.9 adayını değiştirir; imzalı güncelleme adresleri yalnız nihai dosyalar kontrol edildikten sonra etkinleştirilir.

Ek doğrulama: Mevcut müşterinin eski stok hareketi kısıtları ana masaüstü ve HTTPS sunucusu açılışında idempotent güncellenir; ayrıca tablo kontrolü düğmesine basmak gerekmez. Depo alış evrakında yalnız gerekli ürün/tedarikçi/raf adları depo + stok kabul yetkisiyle seçilir; kullanıcıya tüm cari/muhasebe ekranı yetkisi vermek gerekmez. Son SQL testi eski stok kısıtını yeniden kurup otomatik yükseltmeyi iki kez çağırır ve yeni alış/satış işlemlerini doğrular.
