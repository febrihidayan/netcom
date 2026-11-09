<?php

use App\Http\Controllers\CustomerController;
use App\Http\Controllers\DashboardController;
use App\Http\Controllers\GeolocationController;
use App\Http\Controllers\OrderController;
use App\Http\Controllers\OrderItemController;
use App\Http\Controllers\OrderPaymentController;
use App\Http\Controllers\OrderReviewController;
use App\Http\Controllers\ProductCategoryTranslationController;
use App\Http\Controllers\ProductController;
use App\Http\Controllers\SellerController;
use Illuminate\Support\Facades\Route;

Route::inertia('/', 'Welcome')->name('home');

Route::middleware(['auth'])->group(function () {
    Route::get('dashboard', [DashboardController::class, 'index'])->name('dashboard');

    Route::resource('geolocations', GeolocationController::class)->parameters(['geolocations' => 'geolocation']);
    Route::resource('customers', CustomerController::class)->parameters(['customers' => 'customer']);
    Route::resource('sellers', SellerController::class)->parameters(['sellers' => 'seller']);
    Route::resource('product-categories', ProductCategoryTranslationController::class)->parameters(['product-categories' => 'productCategoryTranslation']);
    Route::resource('products', ProductController::class)->parameters(['products' => 'product']);
    Route::resource('orders', OrderController::class)->parameters(['orders' => 'order']);
    Route::resource('order-items', OrderItemController::class)->parameters(['order-items' => 'orderItem']);
    Route::resource('order-payments', OrderPaymentController::class)->parameters(['order-payments' => 'orderPayment']);
    Route::resource('order-reviews', OrderReviewController::class)->parameters(['order-reviews' => 'orderReview']);
});

require __DIR__.'/settings.php';
