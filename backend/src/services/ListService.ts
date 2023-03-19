import { PrismaClient, Product } from "@prisma/client";
const prisma = new PrismaClient();

async function query(list: string[]) {
    const _list: {
        Lidl: Product[];
        Kaufland: Product[];
    } = {
        "Lidl": [],
        "Kaufland": []
    };

    for (const query of list) {
        const result = await prisma.product.findFirst({
            where: {
                AND: [
                    {name: { search: query }},
                    {storeName: "Lidl"}
                ]
            },
        });

        result && _list.Lidl.push(result);
    }

    for (const query of list) {
        const result = await prisma.product.findFirst({
            where: {
                AND: [
                    {name: { search: query }},
                    {storeName: "Kaufland"}
                ]
            },
        });

        result && _list.Kaufland.push(result);
    }

    return _list;
}

export default {
    query
}