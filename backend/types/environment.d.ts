declare global {
    namespace NodeJS {
        interface ProcessEnv {
            DB_HOST: string,
            DB_USER: string,
            DB_PASSWORD: string,
            DB_PORT: number,
            DB_NAME: string,

            API_PORT: number,
            API_DOMAIN: string,
            API_PROTOCOL: string,

            NODE_ENV: "dev" | "production",
            JWT_SECRET: string,
        }
    }
}

// If this file has no import/export statements (i.e. is a script)
// convert it into a module by adding an empty export statement.
export { }