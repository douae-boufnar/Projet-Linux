<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Storage;

class LivreSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        // Créer le dossier pdfs s'il n'existe pas
        if (!Storage::disk('public')->exists('pdfs')) {
            Storage::disk('public')->makeDirectory('pdfs');
        }

        // Créer un fichier PDF dummy
        $dummyPdfPath = 'pdfs/dummy.pdf';
        if (!Storage::disk('public')->exists($dummyPdfPath)) {
            // Un contenu PDF minimal valide
            $pdfContent = "%PDF-1.4\n1 0 obj\n<< /Type /Catalog /Pages 2 0 R >>\nendobj\n2 0 obj\n<< /Type /Pages /Kids [3 0 R] /Count 1 >>\nendobj\n3 0 obj\n<< /Type /Page /Parent 2 0 R /Resources << /Font << /F1 4 0 R >> >> /MediaBox [0 0 612 792] /Contents 5 0 R >>\nendobj\n4 0 obj\n<< /Type /Font /Subtype /Type1 /BaseFont /Helvetica >>\nendobj\n5 0 obj\n<< /Length 44 >>\nstream\nBT /F1 24 Tf 100 700 Td (Ceci est un PDF de test.) Tj ET\nendstream\nendobj\nxref\n0 6\n0000000000 65535 f \n0000000009 00000 n \n0000000058 00000 n \n0000000115 00000 n \n0000000219 00000 n \n0000000306 00000 n \ntrailer\n<< /Size 6 /Root 1 0 R >>\nstartxref\n399\n%%EOF";
            Storage::disk('public')->put($dummyPdfPath, $pdfContent);
        }

        $categories = DB::table('categories')->pluck('id')->toArray();

        if (empty($categories)) {
            $categories = [1, 2, 3, 4, 5]; // Default ids from init.sql
        }

        $livres = [
            [
                'titre' => 'Mastering Laravel 11',
                'auteur' => 'Taylor Otwell',
                'description' => 'Le guide ultime pour maîtriser le framework PHP le plus populaire. Apprenez à construire des applications robustes, scalables et élégantes en utilisant les dernières fonctionnalités de Laravel 11, de la gestion des bases de données aux API RESTful complexes.',
                'image' => 'https://images.unsplash.com/photo-1599507591144-6650f9ee285d?auto=format&fit=crop&w=400&q=80',
                'contenu' => $dummyPdfPath,
                'category_id' => $categories[0] ?? 1,
            ],
            [
                'titre' => 'Intelligence Artificielle Moderne',
                'auteur' => 'Yann LeCun',
                'description' => 'Plongez dans le futur de la technologie avec ce manuel complet sur le Deep Learning. Découvrez comment les réseaux de neurones transforment notre monde, de la reconnaissance vocale à la conduite autonome.',
                'image' => 'https://images.unsplash.com/photo-1507146426996-ef05306b995a?auto=format&fit=crop&w=400&q=80',
                'contenu' => $dummyPdfPath,
                'category_id' => $categories[1] ?? 2,
            ],
            [
                'titre' => 'Les Misérables',
                'auteur' => 'Victor Hugo',
                'description' => 'Un chef-d\'œuvre intemporel qui explore la rédemption, l\'amour et la lutte contre l\'injustice dans le Paris post-révolutionnaire. Suivez le destin extraordinaire de Jean Valjean dans cette épopée bouleversante.',
                'image' => 'https://images.unsplash.com/photo-1544947950-fa07a98d237f?auto=format&fit=crop&w=400&q=80',
                'contenu' => $dummyPdfPath,
                'category_id' => $categories[2] ?? 3,
            ],
            [
                'titre' => 'Une Brève Histoire du Temps',
                'auteur' => 'Stephen Hawking',
                'description' => 'L\'un des plus grands esprits de notre époque nous emmène dans un voyage fascinant à travers l\'espace et le temps. Des trous noirs aux origines de l\'univers, découvrez les secrets du cosmos.',
                'image' => 'https://images.unsplash.com/photo-1451187580459-43490279c0fa?auto=format&fit=crop&w=400&q=80',
                'contenu' => $dummyPdfPath,
                'category_id' => $categories[3] ?? 4,
            ],
            [
                'titre' => 'Clean Code',
                'auteur' => 'Robert C. Martin',
                'description' => 'La bible du développement logiciel. Apprenez les principes, les motifs et les pratiques de l\'artisanat logiciel pour écrire du code qui est non seulement fonctionnel, mais aussi lisible et maintenable sur le long terme.',
                'image' => 'https://images.unsplash.com/photo-1542831371-29b0f74f9713?auto=format&fit=crop&w=400&q=80',
                'contenu' => $dummyPdfPath,
                'category_id' => $categories[0] ?? 1,
            ],
        ];

        foreach ($livres as $livre) {
            DB::table('livres')->insert($livre);
        }
    }
}
