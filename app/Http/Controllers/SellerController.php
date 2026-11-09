<?php

namespace App\Http\Controllers;

use App\Models\Geolocation;
use App\Models\Seller;
use Illuminate\Http\Request;
use Inertia\Inertia;

class SellerController extends Controller
{
    protected array $tableFields = ['seller_city','seller_state','seller_zip_code_prefix'];
    protected array $formFields = ['seller_zip_code_prefix','seller_city','seller_state'];
    protected array $labels = [
        'seller_city' => 'City',
        'seller_state' => 'State',
        'seller_zip_code_prefix' => 'Zip Code Prefix',
    ];

    public function index(Request $request)
    {
        $perPage = (int) $request->input('per_page', 15);
        $search = $request->input('search');

        $query = Seller::query();
        if ($search) {
            $query->where(function ($q) use ($search) {
                $q->where('seller_city', 'like', "%{$search}%")
                    ->orWhere('seller_state', 'like', "%{$search}%");
            });
        }

        return Inertia::render('Crud/Index', [
            'title' => 'Sellers',
            'resource' => 'sellers',
            'fields' => $this->tableFields,
            'keyField' => 'id',
            'labels' => $this->labels,
            'items' => $query->paginate($perPage)->withQueryString(),
            'filters' => ['search' => $search, 'per_page' => $perPage],
        ]);
    }

    public function create()
    {
        return Inertia::render('Crud/Create', [
            'title' => 'Seller',
            'resource' => 'sellers',
            'fields' => $this->tableFields,
            'formFields' => $this->formFields,
            'labels' => $this->labels,
            'options' => [
                'seller_zip_code_prefix' => Geolocation::all()->map(fn ($g) => [
                    'value' => $g->geolocation_zip_code_prefix,
                    'label' => $g->geolocation_zip_code_prefix.' - '.$g->geolocation_city,
                ])->values()->all(),
            ],
        ]);
    }

    public function store(Request $request)
    {
        $validated = $request->validate([
            'seller_zip_code_prefix' => 'nullable|string|max:20',
            'seller_city' => 'nullable|string|max:255',
            'seller_state' => 'nullable|string|max:10',
        ]);

        Seller::create($validated);

        return redirect()->route('sellers.index');
    }

    public function show(Seller $seller)
    {
        return Inertia::render('Crud/Show', [
            'title' => 'Seller',
            'resource' => 'sellers',
            'fields' => $this->tableFields,
            'labels' => $this->labels,
            'item' => $seller,
        ]);
    }

    public function edit(Seller $seller)
    {
        return Inertia::render('Crud/Edit', [
            'title' => 'Seller',
            'resource' => 'sellers',
            'fields' => $this->tableFields,
            'formFields' => $this->formFields,
            'labels' => $this->labels,
            'item' => $seller,
            'options' => [
                'seller_zip_code_prefix' => Geolocation::all()->map(fn ($g) => [
                    'value' => $g->geolocation_zip_code_prefix,
                    'label' => $g->geolocation_zip_code_prefix.' - '.$g->geolocation_city,
                ])->values()->all(),
            ],
        ]);
    }

    public function update(Request $request, Seller $seller)
    {
        $validated = $request->validate([
            'seller_zip_code_prefix' => 'nullable|string|max:20',
            'seller_city' => 'nullable|string|max:255',
            'seller_state' => 'nullable|string|max:10',
        ]);

        $seller->update($validated);

        return redirect()->route('sellers.index');
    }

    public function destroy(Seller $seller)
    {
        $seller->delete();

        return redirect()->route('sellers.index');
    }
}