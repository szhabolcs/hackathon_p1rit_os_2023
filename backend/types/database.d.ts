/**
 * Global types go here
 * They don't need to be imported
 */

export { };

declare global {
    interface DBUser {
        name: string,
        email: string,
        passwordHash: string
    }
}