-- Fotos de productos. Correr en Supabase → SQL Editor después de schema.sql.
-- Asocia por nombre + marca + medida y solo escribe las columnas imagen_*.
-- Se puede volver a correr: solo llena productos que aún no tienen foto (no pisa cambios hechos en admin.html).
drop table if exists pg_temp.fotos;
create temp table fotos (nombre text, marca text, medida text, url text, fuente text, revision boolean, nota text);
insert into fotos values
 ('Pan Blanco Chico','Bimbo','350 g','https://cdn.alsuper.com/products/498594.png','https://alsuper.com/producto/%28t%29pan-blanco-498594',false,null),
 ('Pan Blanco Grande','Bimbo','620 g','https://i5-mx.walmartimages.com/samsmx/images/product-images/img_large/981018491l.jpg','https://www.sams.com.mx/ip/pan-blanco-bimbo-620-g/981018491',false,null),
 ('Pan Blanco 24 Rebanadas','Bimbo','620 g','https://i5.walmartimages.com.mx/mg/gm/3pp/asr/d2e4e01d-6971-4021-950b-354dbc0780d0.b73436f716a18a283afd2606c93dc8b5.jpeg?odnBg=ffffff&odnHeight=2000&odnWidth=2000','https://despensa.bodegaaurrera.com.mx/ip/pan-bimbo-blanco-620-g/00750081002918?srsltid=AfmBOorgDKz3JqbtMiqBv439aRU8zXByKrOsHLZnsdeFFQ5kv_9y_Dg-',true,'La ficha coincide en 620 g, pero Bimbo indica 20 rebanadas para esa presentación. Confirma el empaque de 24.'),
 ('Pan con Linaza','Bimbo','610 g','https://chedrauimx.vtexassets.com/arquivos/ids/72145291/7501000300730_00.jpg?v=639179208846930000','https://www.chedraui.com.mx/pan-bimbo-linaza-610g-3018203/p',false,null),
 ('Pan Integral','Bimbo','620 g','https://i5.walmartimages.com.mx/gr/images/product-images/img_large/00750081002206L.jpg','https://www.walmart.com.mx/ip/pan-bimbo-integral-620-g/00750081002206',false,null),
 ('Bollos Broche','Bimbo','465 g','https://lagranbodega.vteximg.com.br/arquivos/ids/301023-1000-1000/7501030433729.jpg?v=638579800355200000','https://www.lagranbodega.com.mx/bimbo-bollo-brioche-6p-465-gr/p',false,null),
 ('Bimbollos Parrilleros','Bimbo','688 g','https://chedrauimx.vtexassets.com/arquivos/ids/73530813/7500810022733_00.jpg?v=639195924896200000','https://www.chedraui.com.mx/Bimbollos-Bimbo-Parrilleros-688g-3806425/p?ta=1753908940',false,null),
 ('Pan de Centeno con Masa Madre','Oroweat','600 g','https://chedrauimx.vtexassets.com/arquivos/ids/64620429/7500810022702_00.jpg?v=639083567899930000','https://www.chedraui.com.mx/pan-oroweat-centeno-600g-3808316/p',false,null),
 ('Medias Noches','Bimbo','340 g','https://convy.mx/cdn/shop/products/Mediasnochesbimbo12001200.png?v=1637084552','https://convy.mx/collections/lanzamientos-bimbo-%F0%9F%8D%9E',false,null),
 ('Bimbollos','Bimbo','450 g','https://chedrauimx.vtexassets.com/arquivos/ids/63850048-800-auto?aspect=true&height=auto&v=639072289345370000&width=800','https://www.chedraui.com.mx/bimbollos-bimbo-450g-3018217/p',false,null),
 ('Roles de Canela','Bimbo','365 g','https://www.soriana.com/on/demandware.static/-/Sites-soriana-grocery-master-catalog/default/dwa659c992/images/product/7501000309726_A.jpg','https://www.soriana.com/pan-dulce-bimbo-roles-canela-365gr/357868.html',false,null),
 ('Galletas Príncipe Domo','Marinela','1 kg','https://i5-mx.walmartimages.com/samsmx/images/product-images/img_large/981033356l.jpg','https://www.sams.com.mx/ip/galleta-principe-marinela-relleno-sabor-a-chocolate-1-134-kg/981033356',true,'La referencia encontrada es una caja de 1.134 kg. Falta confirmar el domo de 1 kg.'),
 ('Bollos Súper Hot Dogs','Bimbo','526 g','https://chedrauimx.vtexassets.com/arquivos/ids/62493352/7503030572415_00.jpg?v=639050693052030000','https://www.chedraui.com.mx/pan-super-hot-dogs-8-piezas-526g-3675820/p',true,'La presentación de 526 g encontrada es Wonder. En tu catálogo figura Bimbo.'),
 ('Roles Glaseados con Canela','Bimbo','205 g','https://lagranbodega.vteximg.com.br/arquivos/ids/293835-1000-1000/7503030374002.jpg?v=638247088134570000','https://www.lagranbodega.com.mx/bimbo-roles-de-canela-glaseados-205-g/p',false,null),
 ('Submarinos Fresa','Marinela','','https://i5-mx.walmartimages.com/mg/gm/3pp/asr/3c016357-91fe-4334-92f5-a052e4a6d9c2.fef2b4be8c09b5c85b4f312ba3fa9e74.jpeg?odnBg=ffffff&odnHeight=2000&odnWidth=2000','https://despensa.bodegaaurrera.com.mx/ip/submarinos-marinela-sabor-fresa-105-g/00750100015337',true,'La referencia muestra 105 g. Confirma el tamaño que vendes.'),
 ('Submarinos Vainilla','Marinela','','https://circulokmx.vtexassets.com/arquivos/ids/165487/2479.jpg?v=638465581238600000','https://www.contigock.com.mx/submarinos-vainilla-3p-marinela-105gr/p',true,'La referencia muestra 105 g. Confirma el tamaño que vendes.'),
 ('Galletas de Arroz','Sanissimo','','https://hebmx.vtexassets.com/arquivos/ids/650638-800-800?aspect=true&height=800&v=638666666794470000&width=800','https://www.heb.com.mx/sanissimo-galletas-de-arroz-integral-108-gr-667917/p',true,'La primera referencia es de arroz integral. Confirma la variedad.'),
 ('Little Bites Sorpresa Bob Esponja','Bimbo','','https://i.ebayimg.com/images/g/g~QAAeSwvpZp2yJ3/s-l500.jpg','https://www.ebay.com/itm/318138081423',true,'La referencia es Little Bites Sorpresa. Confirma que corresponda a la edición de Bob Esponja.'),
 ('Barra de Cereal Fruit en caja','Bimbo','6 piezas','https://calimaxmx.vtexassets.com/arquivos/ids/204760/7501000137237.1.jpg?v=638151995150800000','https://tienda.calimax.com.mx/bran-frut--sabor-fresa--bimbo--240-0---gr--------731360/p',true,'La referencia es Bran Frut de fresa, 6 piezas. Confirma si coincide con el producto registrado como «Fruit».'),
 ('Conchas Vainilla y Chocolate','Tía Rosa','130 g','https://i5-mx.walmartimages.com/mg/gm/3pp/asr/fcf75155-5409-4526-bd8d-8656cd4fdec1.39282c79d24faa91d4c54bf8f2c62bf3.jpeg?odnBg=ffffff&odnHeight=2000&odnWidth=2000','https://despensa.bodegaaurrera.com.mx/ip/conchas-tia-rosa-vainilla-y-chocolate-2-pzas-130-g/00750103043122',false,null),
 ('Chocorroles','Marinela','','https://d2g10w8g19lwbg.cloudfront.net/s3fs-public/images/2024-03/chocoroles-pastelitos-80g.png?VersionId=Gvtj1RZIRmamNUPGvs7wSCR0s66ySo_O','https://marinela.com.mx/choco-roles',false,null),
 ('Rebanadas','Bimbo','','https://calimaxmx.vtexassets.com/arquivos/ids/213557/7501000112845.jpg?v=638677474033700000','https://tienda.calimax.com.mx/rebanadas--vainilla--bimbo--55-0---gr--------174070/p',false,null),
 ('Donas','Bimbo','','https://cdn.alsuper.com/products/450618.png','https://alsuper.com/producto/donas-azucaradas-6pz-450618',true,'La referencia muestra 6 donas. Confirma la cantidad que vendes.'),
 ('Santines Hershey''s','Hershey''s','','https://i5.walmartimages.com.mx/mg/gm/3pp/asr/4e19e28c-47e8-4c38-a591-3a5265b4fc6a.cd0b31a837f2a9dffe7fbfbceefd8606.jpeg?odnBg=ffffff&odnHeight=2000&odnWidth=2000','https://despensa.bodegaaurrera.com.mx/ip/pan-dulce-crossantines-minis-hershey-s-60-g/00750081004569?srsltid=AfmBOoqdFrgEBY9HwtUOdHlVehavYAR_Sbj3fvNX8yMzjxPh9VVV0alg',true,'La referencia dice Crossantines Minis Hershey’s. Confirma si es el producto registrado como «Santines».'),
 ('Canelitas Bites','Marinela','','https://marinela-com-mx-assets.s3.amazonaws.com/s3fs-public/images/2024-03/canelitas-bites-80g.png?VersionId=tiOaAbWqAWizGmolgNagslLBIp5GyF5k','https://marinela.com.mx/canelitas',false,null),
 ('Panqué con Pasas','Bimbo','','https://bimbo-com-mx-assets.s3.amazonaws.com/product_sweet_bread_bimbo/Carrusel1_6.png?VersionId=Oj_inKWiZGVWUNYHyea_Zf9t9jhGYyGp','https://www.bimbo.com.mx/es/all-products/pan-dulce?page=1',false,null),
 ('Panqué Hershey''s','Bimbo','','https://http2.mlstatic.com/D_987603-MLM105685685024_012026-C.jpg','https://listado.mercadolibre.com.mx/palitos-de-pan-bimbo',false,null),
 ('Pingüinos Hershey''s','Marinela','','https://chedrauimx.vtexassets.com/arquivos/ids/67566038/7500810041857_00.jpg?v=639118138371100000','https://www.chedraui.com.mx/pinguino-marinela-hersheys-80g-3876248/p',false,null),
 ('Pingüinos','Marinela','','https://marinela-com-mx-assets.s3.amazonaws.com/s3fs-public/images/2024-07/Sitio-Pinguinos-Empaques.png?VersionId=bCMjYYwy8qvlOH_SXj3bH97QArf6MP6U','https://marinela.com.mx/pinguinos',false,null),
 ('Cuernitos','Tía Rosa','','https://chedrauimx.vtexassets.com/arquivos/ids/67643372/7501030475484_00.jpg?v=639118948234100000','https://www.chedraui.com.mx/pan-dulce-tia-rosa-cuernitos-200g-3311121/p',true,'La referencia muestra 200 g. Confirma el tamaño que vendes.'),
 ('Pingüinos Calaverita','Marinela','','https://i5.walmartimages.com.mx/mg/gm/3pp/asr/07d5877e-c527-4448-ada3-53df67baebb3.6c3e5652aff24c418b3547e145160a72.jpeg?odnBg=ffffff&odnHeight=2000&odnWidth=2000','https://despensa.bodegaaurrera.com.mx/ip/pastelitos-marinela-pinguinos-calaverita-fresa-2p-80g/00750081004342?srsltid=AfmBOoqmAx7LHXsUq_Uk7HE37xA4kII0Am-bQ7e7u35WgIRvFllsvlSC',false,null),
 ('Pingüinos','Marinela','3 piezas','https://cdn.shopify.com/s/files/1/0372/4450/2149/products/7501030475743_994x994.png?v=1612467527','https://www.fpsf.mx/products/pinguinos-3-piezas120-g-marinela',false,null),
 ('Mantecadas con Nuez','Bimbo','','https://bimbo-com-mx-assets.s3.amazonaws.com/product_sweet_bread_bimbo/Carrusel1_10.png?VersionId=LIiDf_.BUt4kcFl4DddFyG.Xut7Kwlxj','https://www.bimbo.com.mx/es/all-products/pan-dulce?page=1',false,null),
 ('Gansito','Marinela','','https://d2g10w8g19lwbg.cloudfront.net/s3fs-public/images/2024-03/gansito-pastelito-50gr.png?VersionId=dN2KnTzpEMx04mnDKfrSuMZzw00p6zhG','https://marinela.com.mx/gansito',false,null),
 ('Negrito','Bimbo','Individual','https://metepec.grillhouse.mx/cdn/shop/products/NITO1PZABIMBO62G_1024x.png?v=1698268023','https://metepec.grillhouse.mx/products/nito-1-pza-bimbo-62-g',false,null),
 ('Duo Nito','Bimbo','','https://mercar.com.mx/storage/2025/05/165900-1200-auto.webp','https://mercar.com.mx/tienda/alimentos/bimbo-nito-duo-124g/',false,null),
 ('Fruti Sabor Mango','Marinela','','https://i5-mx.walmartimages.com/mg/gm/3pp/asr/15ffbfd9-f0a3-4e30-ae7d-ee49524fbad1.da8f7e6b17e986c815effa7e8e2b7707.jpeg?odnBg=FFFFFF&odnHeight=612&odnWidth=612','https://despensa.bodegaaurrera.com.mx/ip/galletas-marinela-fruti-sponch-sabor-mango-8p-124g/00750081004047',true,'La referencia dice Fruti Sponch Mango. Confirma que corresponda a «Fruti Sabor Mango».'),
 ('Pay','Marinela','3 piezas','https://i.ebayimg.com/images/g/FK4AAeSwOP1pneqg/s-l1200.jpg','https://www.ebay.com/itm/286597295889',true,'La referencia es mini pay de nuez de 2 piezas. Falta confirmar el sabor y el empaque de 3 piezas.'),
 ('Pay de Nuez','Marinela','3 piezas','https://images.squarespace-cdn.com/content/v1/5c702585bfba3e6ae70d8095/1708735062743-SVXPO42MZZPKPSU7ADVG/AD032472-065D-4978-B7C7-A7752E7612AB?format=2500w','https://www.mexicansstuff.com/cereales-y-galletas/iw0scite6850789ap7cw2xvckpfz16',true,'La referencia muestra 2 piezas. Falta confirmar la presentación de 3.'),
 ('Pastelito Hershey''s','Bimbo','','https://i5-mx.walmartimages.com/mg/gm/3pp/asr/e61b2886-7416-4f67-8139-0a44b912f074.4a8ac70eece083ae6251102c4a60970b.jpeg?odnBg=ffffff&odnHeight=2000&odnWidth=2000','https://despensa.bodegaaurrera.com.mx/ip/pastelito-bimbo-marinela-hershey-s-40g/00750081003904',true,'La ficha lo identifica como Marinela y Hershey’s. En el catálogo figura Bimbo.'),
 ('Pastelito Hershey''s','Bimbo','3 piezas','https://i5-mx.walmartimages.com/mg/gm/3pp/asr/e61b2886-7416-4f67-8139-0a44b912f074.4a8ac70eece083ae6251102c4a60970b.jpeg?odnBg=ffffff&odnHeight=2000&odnWidth=2000','https://despensa.bodegaaurrera.com.mx/ip/pastelito-bimbo-marinela-hershey-s-40g/00750081003904',true,'La referencia encontrada es de 40 g. Falta confirmar la presentación de 3 piezas.'),
 ('Donitas Glaseadas','Bimbo','','https://i5-mx.walmartimages.com/gr/images/product-images/img_large/00750103042954L2.jpg?odnBg=FFFFFF&odnHeight=612&odnWidth=612','https://www.walmart.com.mx/ip/donas-bimbo-glasse-4-pzas-de-52-g-c-u/00750103042954',true,'La referencia es Bimbo Glassé. Confirma que coincida con el empaque que vendes.'),
 ('Pingüinos Mini','Marinela','','https://i5.walmartimages.com.mx/mg/gm/3pp/asr/e170e46e-b82e-4f12-a2aa-dc81812fa8ce.5c7d0553d630aac50cdec3587588a58d.jpeg?odnBg=ffffff&odnHeight=2000&odnWidth=2000','https://despensa.bodegaaurrera.com.mx/ip/pinguinos-marinela-25-g/00750103041909?srsltid=AfmBOopDmRmOAMNBaqtwAWZQjd_egXLUcGl1iWJ0yK7hLrP6FGh6--In',true,'La primera referencia muestra la presentación de 25 g. Confirma el tamaño que vendes.'),
 ('Cuernitos Rebanados','Tía Rosa','','https://www.lacomer.com.mx/superc/img_art/7501030475484_3.jpg','https://tienda.lacomer.com.mx/lacomer/',false,null);

update public.products p
   set imagen_url = f.url, imagen_fuente = f.fuente, imagen_revision = f.revision, imagen_nota = f.nota
  from fotos f
 where lower(trim(p.nombre)) = lower(trim(f.nombre))
   and lower(trim(p.marca))  = lower(trim(f.marca))
   and lower(trim(p.medida)) = lower(trim(f.medida))
   and p.imagen_url is null;

-- Reporte
with par as (
  select f.nombre fn, f.marca fm, f.medida fd, p.id, p.nombre, p.marca, p.medida, p.imagen_url, p.imagen_revision, p.imagen_nota
    from fotos f
    full join public.products p
      on lower(trim(p.nombre)) = lower(trim(f.nombre))
     and lower(trim(p.marca))  = lower(trim(f.marca))
     and lower(trim(p.medida)) = lower(trim(f.medida))
)
select 'foto sin producto' as caso, fn as nombre, fm as marca, fd as medida, null as nota from par where id is null
union all
select 'producto sin foto', nombre, marca, medida, null from par where id is not null and imagen_url is null
union all
select distinct 'pendiente de revisión', nombre, marca, medida, imagen_nota from par where imagen_revision
order by 1, 2, 4;
