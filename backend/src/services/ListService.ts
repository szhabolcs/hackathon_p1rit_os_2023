function query(list: string[]) {
    //TODO: query and search data from DB
    const ret = [
        {
            "Lidl": [
                {
                    name: "Carne tocată vită-porc",
                    price: 17.99,
                    discountedPrice: 16.99,
                    unitOfMeasure: "1 kg",
                    image: "https://ro.cat-ret.assets.lidl/catalog5media/ro/article/6806834/third/lg/6806834_11.jpg"
                }
            ],
            "Kaufland": [
                {
                    name: "SABIN Telemea proaspătă din lapte de vacă 100 g",
                    price: 2.69,
                    discountedPrice: 2.39,
                    unitOfMeasure: "100 g",
                    image: "https://kaufland.media.schwarz/is/image/schwarz/2867730000000_RO_P?JGstbGVnYWN5LW9uc2l0ZS0xJA=="
                }
            ]
        }
    ]
    
    return ret;
}

export default {
    query
}