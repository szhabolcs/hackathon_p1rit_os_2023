import { createUser, getUser, userExists } from "../models/UserModel.js";
import bcrypt from 'bcrypt';
import jwt from 'jsonwebtoken';
import NodeCache from 'node-cache';
import { User } from "@prisma/client";

const tokenCache = new NodeCache({ stdTTL: 3600 }); // one hour

async function register(user: RegisterUser): Promise<string> {
    if (await userExists(user.email)) {
        throw new Error(`User with email ${user.email} already exists`);
    }

    const newUser = await createUser({
        email: user.email,
        name: user.email,
        passwordHash: await bcrypt.hash(user.password, await bcrypt.genSalt())
    });

    return createToken(newUser);
}

async function login(user: LoginUser): Promise<string> {
    if (!(await userExists(user.email))) {
        throw new Error(`User with email ${user.email} does not exists`);
    }

    const _user = await getUser(user.email, user.password);
    return createToken(_user);
}

function createToken(user: User) {
    const token = jwt.sign({ user }, process.env.JWT_SECRET, { expiresIn: "1h" });
    tokenCache.set<undefined>(token, undefined);
    return token;
}

export default {
    register,
    login,
    tokenCache
}