parse-example
=============


Bu projede parse ile cloud üzerinde iphone ile işlemler yapılması hedeflernmiştir.

KURULUM
=======

- parse için gerekli dosyalar proje içindedir zaten tek yapmanız gereken uygulamanız için parse.com sitesinde cloud hesabi oluşturup applicationID ve clientID almak ve bunları

ParseAppDelegate.m dosyasında belirtilen yere yazmanız.

bunu yaptıktan sonra uygulama çalışır. ancak facelogin butonu çalışmaz.

- facebook login içinde önce face developer hesabınız ile app oluşturmanız ve bir facebookID si almanız gerekiyor. bunları yaptıktan sonra.

parseExample-Info.plist dosyasını xcodeda açın ve orada facebookID yazan yere kendi facebookID nizi giriniz.

yine aynı dosyada Url types-Item-Url Schemes-Item 0 altındaki yere facebookID nizin başına fb ekleyerek buraya yazıyoruz. ve artık facebook uygulamanız içinde gerekli ayarlamaları yapmış bulunuyoruz.

artık uygulamayı çalıştırabilirsiniz.