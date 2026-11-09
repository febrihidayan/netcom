<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Concerns\HasUuids;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;

class Product extends Model
{
    use HasFactory;
    use HasUuids;

    protected $fillable = [
        'product_category_name',
        'product_name_length',
        'product_description_length',
        'product_photos_qty',
        'product_weight_g',
        'product_length_cm',
        'product_height_cm',
        'product_width_cm',
    ];

    protected $casts = [
        'product_weight_g' => 'decimal:2',
        'product_length_cm' => 'decimal:2',
        'product_height_cm' => 'decimal:2',
        'product_width_cm' => 'decimal:2',
    ];

    public function category(): BelongsTo
    {
        return $this->belongsTo(ProductCategoryTranslation::class, 'product_category_name', 'product_category_name');
    }

    public function orderItems(): HasMany
    {
        return $this->hasMany(OrderItem::class, 'product_id');
    }
}