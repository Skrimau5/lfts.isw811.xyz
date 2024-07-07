<x-dropdown>
            <x-slot name="trigger">
                <button class="py-2 pl-3 pr-9 text-sm font-semibold w-full lg:w-32 text-left flex lg:inline-flex">{{ isset($currentCategory) ? ucwords($currentCategory->name) :'Categories' }}

                    <svg class="transform -rotate-90 absolute pointer-events-none" style="right: 12px;" width="22" height="22" viewBox="0 0 22 22">
                        <g fill="none" fill-rule="evenodd">
                            <path stroke="#000" stroke-opacity=".012" stroke-width=".5" d="M21 1v20.16H.84V1z">
                            </path>
                            <path fill="#222" d="M13.854 7.224l-3.847 3.856 3.847 3.856-1.184 1.184-5.04-5.04 5.04-5.04z"></path>
                        </g>
                    </svg>
                </button>
            </x-slot>


            <a href="/" class="block text-left px-3 text-sm leading-6 hover:bg-blue-500 focus:bg-blue-500 hover:text-white focus:text-white">All</a>
            <x-dropdown-item href="/" :active="request()->routeIs('home')">All</x-dropdown-item>

            @foreach ($categories as $category)
            <x-dropdown-item>
            <a href="/?category={{ $category->slug }}&{{ http_build_query(request()->except('category')) }}"
            :active='request()->is("categories/{$category->slug}")'
            >{{ ucwords($category->name) }}</x-dropdown-item>
            @endforeach
        </x-dropdown>