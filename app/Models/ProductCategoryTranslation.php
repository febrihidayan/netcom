<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\HasMany;

class ProductCategoryTranslation extends Model
{
    use HasFactory;
    protected $table = 'product_category_translations';
    protected $primaryKey = 'product_category_name';
    public $incrementing = false;
    protected $keyType = 'string';

    protected $fillable = [
        'product_category_name',
        'product_category_name_english',
    ];

    public function products(): HasMany
    {
        return $this->hasMany(Product::class, 'product_category_name', 'product_category_name');
    }
}