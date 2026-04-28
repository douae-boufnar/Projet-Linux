import { Category } from './category.model';

export interface Livre {
  id: number;
  titre: string;
  auteur: string;
  description: string;
  image?: string;
  contenu?: string;
  category_id: number;
  created_at?: string;
  category?: Category;
}
