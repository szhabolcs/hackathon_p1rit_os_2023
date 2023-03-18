/**
 * Global types go here
 * They don't need to be imported
 */

export { };

declare global {
    interface RegisterUser {
        name: string,
        email: string,
        password: string
    }
    interface LoginUser {
        email: string,
        password: string
    }
    interface TokenUser {
        id: number,
        name: string,
        email: string
    }

    const enum ResponseCode {
        /** The request was successfully completed. */
        Ok = 200,
        /** A new resource was successfully created. */
        Created = 201,
        /** The request was invalid. */
        BadRequest = 400,
        /** The request did not include an authentication token or the authentication token was expired. */
        Unauthorized = 401,
        /** The client did not have permission to access the requested resource. */
        Forbidden = 403,
        /** The requested resource was not found. */
        NotFound = 404,
        /** The HTTP method in the request was not supported by the resource. For example, the DELETE method cannot be used with the Agent API. */
        MethodNotAllowed = 405,
        /** The request could not be completed due to a conflict. For example,  POST ContentStore Folder API cannot complete if the given file or folder name already exists in the parent location. */
        Conflict = 409,
        /** The request was not completed due to an internal error on the server side. */
        InternalServerError = 500,
        /** The server was unavailable. */
        ServiceUnavailable = 503
    }
}