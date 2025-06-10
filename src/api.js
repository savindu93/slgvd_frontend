import axios from "axios";
import { ACCESS_TOKEN } from "./constants";

const api = axios.create({

    baseURL: "https://slgvd-backend-575906908337.asia-south1.run.app"
})

api.interceptors.request.use(

    (config) => {
        
        const token = localStorage.getItem(ACCESS_TOKEN);

        const restrictedEndpoints = ['upload/', 'update/', 'remove/', 
            'retrieve-by-user/']

        const isRestricted = restrictedEndpoints.some((endpoint) => config.url.includes(endpoint))

        if(token && isRestricted){
            config.headers.Authorization = `Bearer ${token}`;
        }

        return config;
    },
    (error) => {

        return Promise.reject(error);
    }
)

export default api;