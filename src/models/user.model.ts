import mongoose, { Schema } from 'mongoose';
import { IUserDocument } from '../types/user.types';

const ProjectSchema = new Schema({
  name: { type: String, required: true },
  description: { type: String, required: true },
  technologies: [{ type: String }]
});

const UserSchema = new Schema({
  name: { type: String, required: true },
  summary: { type: String, required: true },
  age: { type: Number, required: true },
  city: { type: String, required: true },
  language: [{ type: String, required: true }],
  projects: [ProjectSchema]
}, {
  timestamps: true
});

export default mongoose.model<IUserDocument>('User', UserSchema); 