<?php

namespace App\Http\Controllers;

use App\Models\Product;
use App\Models\ProductCategoryTranslation;
use Illuminate\Http\Request;
use Inertia\Inertia;

class ProductController extends Controller
{
    protected array $tableFields = ['product_category_name','product_weight_g','product_length_cm','product_height_cm','product_width_cm'];
    protected array $formFields = ['product_category_name','product_name_length','product_description_length','product_photos_qty','product_weight_g','product_length_cm','product_height_cm','product_width_cm'];
    protected array $labels = [
        'product_category_name' => 'Category',
        'product_weight_g' => 'Weight (g)',
        'product_length_cm' => 'Length (cm)',
        'product_height_cm' => 'Height (cm)',
        'product_width_cm' => 'Width (cm)',
    ];

    public function index(Request $request)
    {
        $perPage = (int) $request->input('per_page', 15);
        $search = $request->input('search');

        $query = Product::query();
        if ($search) {
            $query->where(function ($q) use ($search) {
                $q->where('product_category_name', 'like', "%{$search}%");
            });
        }

        return Inertia::render('Crud/Index', [
            'title' => 'Products',
            'resource' => 'products',
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
            'title' => 'Product',
            'resource' => 'products',
            'fields' => $this->tableFields,
            'formFields' => $this->formFields,
            'labels' => $this->labels,
            'options' => [
                'product_category_name' => ProductCategoryTranslation::all()->map(fn ($c) => [
                    'value' => $c->product_category_name,
                    'label' => $c->product_category_name.' ('.($c->product_category_name_english ?? '-').')',
                ])->values()->all(),
            ],
        ]);
    }

    public function store(Request $request)
    {
        $validated = $request->validate([
            'product_category_name' => 'nullable|string|max:255',
            'product_name_length' => 'nullable|integer',
            'product_description_length' => 'nullable|integer',
            'product_photos_qty' => 'nullable|integer',
            'product_weight_g' => 'nullable|numeric',
            'product_length_cm' => 'nullable|numeric',
            'product_height_cm' => 'nullable|numeric',
            'product_width_cm' => 'nullable|numeric',
        ]);

        Product::create($validated);

        return redirect()->route('products.index');
    }

    public function show(Product $product)
    {
        return Inertia::render('Crud/Show', [
            'title' => 'Product',
            'resource' => 'products',
            'fields' => $this->tableFields,
            'labels' => $this->labels,
            'item' => $product,
        ]);
    }

    public function edit(Product $product)
    {
        return Inertia::render('Crud/Edit', [
            'title' => 'Product',
            'resource' => 'products',
            'fields' => $this->tableFields,
            'formFields' => $this->formFields,
            'labels' => $this->labels,
            'item' => $product,
            'options' => [
                'product_category_name' => ProductCategoryTranslation::all()->map(fn ($c) => [
                    'value' => $c->product_category_name,
                    'label' => $c->product_category_name.' ('.($c->product_category_name_english ?? '-').')',
                ])->values()->all(),
            ],
        ]);
    }

    public function update(Request $request, Product $product)
    {
        $validated = $request->validate([
            'product_category_name' => 'nullable|string|max:255',
            'product_name_length' => 'nullable|integer',
            'product_description_length' => 'nullable|integer',
            'product_photos_qty' => 'nullable|integer',
            'product_weight_g' => 'nullable|numeric',
            'product_length_cm' => 'nullable|numeric',
            'product_height_cm' => 'nullable|numeric',
            'product_width_cm' => 'nullable|numeric',
        ]);

        $product->update($validated);

        return redirect()->route('products.index');
    }

    public function destroy(Product $product)
    {
        $product->delete();

        return redirect()->route('products.index');
    }
}