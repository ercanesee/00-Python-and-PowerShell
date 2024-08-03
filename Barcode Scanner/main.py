import segno

qr = segno.make_qr("https://ercanese.com")

qr.save(
    "demo.png",
    border=2,
    scale=7,
    light="gainsboro",

)