<?php

namespace App\Http\Controllers;

use App\Models\ProductCategoryTranslation;
use Illuminate\Http\Request;
use Inertia\Inertia;

class ProductCategoryTranslationController extends Controller
{
    protected array $tableFields = ['product_category_name','product_category_name_english'];
    protected array $formFields = ['product_category_name','product_category_name_english'];
    protected array $labels = [
        'product_category_name' => 'Category Name',
        'product_category_name_english' => 'Category Name (English)',
    ];

    public function index(Request $request)
    {
        $perPage = (int) $request->input('per_page', 15);
        $search = $request->input('search');

        $query = ProductCategoryTranslation::query();
        if ($search) {
            $query->where(function ($q) use ($search) {
                $q->where('product_category_name', 'like', "%{$search}%")
                    ->orWhere('product_category_name_english', 'like', "%{$search}%");
            });
        }

        return Inertia::render('Crud/Index', [
            'title' => 'Product Categories',
            'resource' => 'product-categories',
            'fields' => $this->tableFields,
            'keyField' => 'product_category_name',
            'labels' => $this->labels,
            'items' => $query->paginate($perPage)->withQueryString(),
            'filters' => ['search' => $search, 'per_page' => $perPage],
        ]);
    }

    public function create()
    {
        return Inertia::render('Crud/Create', [
            'title' => 'Product Category',
            'resource' => 'product-categories',
            'fields' => $this->tableFields,
            'formFields' => $this->formFields,
            'labels' => $this->labels,
        ]);
    }

    public function store(Request $request)
    {
        $validated = $request->validate([
            'product_category_name' => 'required|string|max:255',
            'product_category_name_english' => 'nullable|string|max:255',
        ]);

        ProductCategoryTranslation::create($validated);

        return redirect()->route('product-categories.index');
    }

    public function show(ProductCategoryTranslation $productCategoryTranslation)
    {
        return Inertia::render('Crud/Show', [
            'title' => 'Product Category',
            'resource' => 'product-categories',
            'fields' => $this->tableFields,
            'labels' => $this->labels,
            'item' => $productCategoryTranslation,
        ]);
    }

    public function edit(ProductCategoryTranslation $productCategoryTranslation)
    {
        return Inertia::render('Crud/Edit', [
            'title' => 'Product Category',
            'resource' => 'product-categories',
            'fields' => $this->tableFields,
            'formFields' => $this->formFields,
            'labels' => $this->labels,
            'item' => $productCategoryTranslation,
        ]);
    }

    public function update(Request $request, ProductCategoryTranslation $productCategoryTranslation)
    {
        $validated = $request->validate([
            'product_category_name_english' => 'nullable|string|max:255',
        ]);

        $productCategoryTranslation->update($validated);

        return redirect()->route('product-categories.index');
    }

    public function destroy(ProductCategoryTranslation $productCategoryTranslation)
    {
        $productCategoryTranslation->delete();

        return redirect()->route('product-categories.index');
    }
}