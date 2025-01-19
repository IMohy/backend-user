export interface IProject {
  name: string;
  description: string;
  technologies: string[];
}

export interface IUser {
  name: string;
  summary: string;
  age: number;
  city: string;
  language: string[];
  projects: IProject[];
}

export interface IUserDocument extends IUser, Document {} 