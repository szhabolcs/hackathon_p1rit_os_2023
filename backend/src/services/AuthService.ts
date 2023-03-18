import { createUser, getUser, userExists } from "../models/UserModel.js";
import bcrypt from 'bcrypt';
import jwt from 'jsonwebtoken';
import NodeCache from 'node-cache';

const tokenCache = new NodeCache({ stdTTL: 3600 }); // one hour
const refreshTokenCache = new NodeCache({ stdTTL: 2630000 }); // one month

async function register(user: RegisterUser): Promise<{token: string, refresh: string}> {
    if (await userExists(user.email)) {
        throw new Error(`User with email ${user.email} already exists`);
    }

    const newUser = await createUser({
        email: user.email,
        name: user.name,
        passwordHash: await bcrypt.hash(user.password, await bcrypt.genSalt())
    });

    return {
        "token": createToken(newUser),
        "refresh": createToken(newUser, "refresh")
    };
}

async function login(user: LoginUser): Promise<{token: string, refresh: string}> {
    if (!(await userExists(user.email))) {
        throw new Error(`User with email ${user.email} does not exists`);
    }

    const _user = await getUser(user.email);
    const match = await bcrypt.compare(user.password, _user.password);
    
    if (match)
        return {
            "token": createToken(_user),
            "refresh": createToken(_user, "refresh")
        };
    
    throw new Error("Password does not match");
    
}

async function refresh(user: TokenUser, refreshtoken: string) {
    if (refreshTokenCache.has(refreshtoken) === false) {
        throw new Error(`Token: ${refreshtoken} does not exist`);
    }
    
    refreshTokenCache.del(refreshtoken);

    return {
        "token": createToken(user),
        "refresh": createToken(user, "refresh")
    };
}

function createToken(user: TokenUser, type: "token" | "refresh" = "token") {
    const expiresIn = type === "token" ? "1h" : "1m";
    const token = jwt.sign({ user }, process.env.JWT_SECRET, { expiresIn });
    
    if (type === "token")
        tokenCache.set<undefined>(token, undefined);
    else 
        refreshTokenCache.set<undefined>(token, undefined);
    
    return token;
}

export default {
    register,
    login,
    refresh,
    tokenCache,
    refreshTokenCache
}