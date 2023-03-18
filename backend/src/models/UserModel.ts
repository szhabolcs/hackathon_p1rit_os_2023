import { PrismaClient } from "@prisma/client";
const prisma = new PrismaClient();

async function userExists(email: string): Promise<boolean> {
  const userExists = await prisma.user.findUnique({
    where: {
      email: email,
    },
  });
  return userExists !== null;
}

async function getUser(email: string) {
  const dbUser = await prisma.user.findFirstOrThrow({
    where: {
      email,
    },
  });
  return dbUser;
}

async function createUser(user: DBUser) {
  const newUser = await prisma.user.create({
    data: {
      email: user.email,
      name: user.name,
      password: user.passwordHash,
    },
  });
  
  return newUser;
}

export { userExists, getUser, createUser };
