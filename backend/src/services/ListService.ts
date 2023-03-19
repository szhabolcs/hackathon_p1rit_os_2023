import { PrismaClient } from "@prisma/client";
const prisma = new PrismaClient();

async function query(list: string[]) {
  const _list: {
    Lidl: ProductWithOthers[];
    Kaufland: ProductWithOthers[];
  } = {
    Lidl: [],
    Kaufland: [],
  };

  _list.Lidl = await getListFromStore(list, "Lidl");
  _list.Kaufland = await getListFromStore(list, "Kaufland");

  return _list;
}

async function getListFromStore(list: string[], store: "Lidl" | "Kaufland") {
  const _list: ProductWithOthers[] = [];

    for (const query of list) {
        const result = await prisma.product.findFirst({
            where: {
                AND: [
                    { name: { search: query } },
                    { storeName: store }
                ]
            },
            orderBy: [{discountedPrice: "asc"}, { price: "asc" }]
        });
        if (result === null)
            continue;

        const others = await prisma.product.findMany({
            where: {
                AND: [
                    { name: { search: query } },
                    { storeName: store },
                    { id: { not: result.id } },
                    { image: { not: result.image } }
                ]
            },
            orderBy: [{discountedPrice: "asc"}, { price: "asc" }]
        });

    const line = {
      id: result.id,
      name: result.name,
      price: result.price,
      discountedPrice: result.discountedPrice,
      unitOfMeasure: result.unitOfMeasure,
      image: result.image,
      storeName: result.storeName,
      others,
    };

    result && _list.push(line);
  }

  return _list;
}

async function save(
  userId: number,
  products: string[],
  query: string,
  sum: number,
  storeName: string
) {
  const groceryList = await prisma.groceryList.create({
    data: {
      userId,
      storeName,
      sum,
      query,
    },
  });

  // console.log(groceryList.id);
  let groceryListLines: any = [];
  products.forEach((product) => {
    groceryListLines.push({
      productId: Number(product),
      quantity: 1,
      groceryListId: groceryList.id,
    });
  });

  const groceryListLine = await prisma.groceryListLine.createMany({
    data: groceryListLines,
  });
}

export default {
  query,
  save,
};
