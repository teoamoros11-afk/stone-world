package com.teo.suikacasco.item;

import com.teo.suikacasco.SuikaCasco;
import net.minecraft.core.registries.Registries;
import net.minecraft.resources.ResourceLocation;
import net.minecraft.sounds.SoundEvents;
import net.minecraft.world.item.ArmorItem;
import net.minecraft.world.item.ArmorMaterial;
import net.minecraft.world.item.Item;
import net.minecraft.world.item.Items;
import net.minecraft.world.item.crafting.Ingredient;
import net.neoforged.bus.api.IEventBus;
import net.neoforged.neoforge.registries.DeferredHolder;
import net.neoforged.neoforge.registries.DeferredItem;
import net.neoforged.neoforge.registries.DeferredRegister;

import java.util.List;
import java.util.Map;

public class ModItems {

    public static final DeferredRegister.Items ITEMS =
            DeferredRegister.createItems(SuikaCasco.MODID);

    public static final DeferredRegister<ArmorMaterial> ARMOR_MATERIALS =
            DeferredRegister.create(Registries.ARMOR_MATERIAL, SuikaCasco.MODID);

    /**
     * Material del casco: dos puntos de armadura (como el casco de cuero), se repara con
     * rodajas de sandia y usa la textura suikacasco:suika_layer_1.png.
     */
    public static final DeferredHolder<ArmorMaterial, ArmorMaterial> SUIKA_SHELL =
            ARMOR_MATERIALS.register("suika",
                    () -> new ArmorMaterial(
                            Map.of(ArmorItem.Type.HELMET, 2),     // defensa
                            15,                                  // encantabilidad
                            SoundEvents.ARMOR_EQUIP_LEATHER,
                            () -> Ingredient.of(Items.MELON_SLICE),
                            List.of(new ArmorMaterial.Layer(
                                    ResourceLocation.fromNamespaceAndPath(SuikaCasco.MODID, "suika"))),
                            0.0F,
                            0.0F));

    /** El casco de sandia de Suika: se lleva en la cabeza. */
    public static final DeferredItem<ArmorItem> WATERMELON_HELMET =
            ITEMS.register("watermelon_helmet",
                    () -> new ArmorItem(SUIKA_SHELL, ArmorItem.Type.HELMET, new Item.Properties()));

    public static void register(IEventBus modEventBus) {
        ARMOR_MATERIALS.register(modEventBus);
        ITEMS.register(modEventBus);
    }
}
