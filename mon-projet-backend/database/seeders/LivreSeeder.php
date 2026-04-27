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
                'titre' => 'Le Guide du Développeur Laravel',
                'auteur' => 'Taylor Otwell',
                'description' => 'Un guide complet pour maîtriser Laravel 10.',
                'contenu' => $dummyPdfPath,
                'category_id' => $categories[0] ?? 1,
            ],
            [
                'titre' => 'Initiation à l\'Intelligence Artificielle',
                'auteur' => 'Yann LeCun',
                'description' => 'Comprendre le deep learning de zéro.',
                'contenu' => $dummyPdfPath,
                'category_id' => $categories[1] ?? 2,
            ],
            [
                'titre' => 'Les Misérables',
                'auteur' => 'Victor Hugo',
                'description' => 'Un classique de la littérature française.',
                'contenu' => $dummyPdfPath,
                'category_id' => $categories[2] ?? 3,
            ],
            [
                'titre' => 'Une Brève Histoire du Temps',
                'auteur' => 'Stephen Hawking',
                'description' => 'Du Big Bang aux Trous Noirs.',
                'contenu' => $dummyPdfPath,
                'category_id' => $categories[3] ?? 4,
            ],
            [
                'titre' => 'Clean Code',
                'auteur' => 'Robert C. Martin',
                'description' => 'A Handbook of Agile Software Craftsmanship.',
                'contenu' => $dummyPdfPath,
                'category_id' => $categories[0] ?? 1,
            ],
        ];

        foreach ($livres as $livre) {
            DB::table('livres')->insert($livre);
        }
    }
}
