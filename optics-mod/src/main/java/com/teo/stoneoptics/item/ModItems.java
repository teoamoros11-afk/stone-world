package com.teo.stoneoptics.item;

import com.teo.stoneoptics.StoneOptics;
import com.teo.stoneoptics.block.ModBlocks;
import net.minecraft.world.item.BlockItem;
import net.minecraft.world.item.Item;
import net.minecraft.world.item.Rarity;
import net.neoforged.bus.api.IEventBus;
import net.neoforged.neoforge.registries.DeferredItem;
import net.neoforged.neoforge.registries.DeferredRegister;

public class ModItems {

    public static final DeferredRegister.Items ITEMS =
            DeferredRegister.createItems(StoneOptics.MODID);

    /** Lente sin pulir: vidrio fundido con forma, todavia turbia. */
    public static final DeferredItem<Item> ROUGH_LENS =
            ITEMS.registerSimpleItem("rough_lens", new Item.Properties());

    /** Lente pulida: ya enfoca. Es la pieza que abre la optica. */
    public static final DeferredItem<Item> POLISHED_LENS =
            ITEMS.registerSimpleItem("polished_lens",
                    new Item.Properties().rarity(Rarity.UNCOMMON));

    /** Telescopio: lente pulida montada en un tubo de cobre. */
    public static final DeferredItem<TelescopeItem> TELESCOPE =
            ITEMS.register("telescope",
                    () -> new TelescopeItem(new Item.Properties().stacksTo(1)));

    /** Gafas de Kinro: vision clara para el guardia miope. */
    public static final DeferredItem<KinroGlassesItem> KINRO_GLASSES =
            ITEMS.register("kinro_glasses",
                    () -> new KinroGlassesItem(new Item.Properties().stacksTo(1).rarity(Rarity.UNCOMMON)));

    /** Banco de pulido como item colocable. */
    public static final DeferredItem<BlockItem> POLISHING_TABLE =
            ITEMS.register("polishing_table",
                    () -> new BlockItem(ModBlocks.POLISHING_TABLE.get(), new Item.Properties()));

    public static void register(IEventBus modEventBus) {
        ITEMS.register(modEventBus);
    }
}
