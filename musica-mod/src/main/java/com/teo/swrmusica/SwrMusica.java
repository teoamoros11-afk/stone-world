package com.teo.swrmusica;

import net.minecraft.core.component.DataComponents;
import net.minecraft.core.registries.Registries;
import net.minecraft.resources.ResourceKey;
import net.minecraft.resources.ResourceLocation;
import net.minecraft.sounds.SoundEvent;
import net.minecraft.world.item.CreativeModeTabs;
import net.minecraft.world.item.EitherHolder;
import net.minecraft.world.item.Item;
import net.minecraft.world.item.JukeboxPlayable;
import net.minecraft.world.item.Rarity;
import net.neoforged.bus.api.IEventBus;
import net.neoforged.fml.ModContainer;
import net.neoforged.fml.common.Mod;
import net.neoforged.neoforge.event.BuildCreativeModeTabContentsEvent;
import net.neoforged.neoforge.registries.DeferredHolder;
import net.neoforged.neoforge.registries.DeferredItem;
import net.neoforged.neoforge.registries.DeferredRegister;

/**
 * El sonido de Lilian y su disco.
 *
 * Un jukebox_song del datapack resuelve su sonido contra el registro del servidor, y un
 * resource pack no registra nada: sin el sound event, el servidor no arranca ("Failed to get
 * element ResourceKey[minecraft:sound_event / swr:lilian]").
 *
 * El disco es un item con el componente jukebox_playable por defecto. Tiene que ser un item:
 * escrito dentro de una funcion, el componente se parsea antes de que el registro de
 * jukebox_song tenga la entrada y la funcion no carga ("Cannot parse as key without registry").
 * EitherHolder guarda solo la clave y la resuelve al usarlo.
 */
@Mod(SwrMusica.MODID)
public class SwrMusica {

    public static final String MODID = "swrmusica";

    public static final DeferredRegister<SoundEvent> SOUNDS =
            DeferredRegister.create(Registries.SOUND_EVENT, MODID);

    public static final DeferredRegister.Items ITEMS =
            DeferredRegister.createItems(MODID);

    public static final DeferredHolder<SoundEvent, SoundEvent> LILIAN =
            SOUNDS.register("lilian", () -> SoundEvent.createVariableRangeEvent(
                    ResourceLocation.fromNamespaceAndPath(MODID, "lilian")));

    public static final ResourceKey<net.minecraft.world.item.JukeboxSong> LILIAN_SONG =
            ResourceKey.create(Registries.JUKEBOX_SONG,
                    ResourceLocation.fromNamespaceAndPath(MODID, "lilian"));

    /** Disco de Lilian: el que se pone en un tocadiscos. */
    public static final DeferredItem<Item> DISCO_LILIAN =
            ITEMS.register("disco_lilian", () -> new Item(new Item.Properties()
                    .stacksTo(1)
                    .rarity(Rarity.RARE)
                    .component(DataComponents.JUKEBOX_PLAYABLE,
                            new JukeboxPlayable(new EitherHolder<>(LILIAN_SONG), true))));

    public SwrMusica(IEventBus modEventBus, ModContainer modContainer) {
        SOUNDS.register(modEventBus);
        ITEMS.register(modEventBus);
        modEventBus.addListener(this::addToCreativeTabs);
    }

    private void addToCreativeTabs(BuildCreativeModeTabContentsEvent event) {
        if (event.getTabKey() == CreativeModeTabs.TOOLS_AND_UTILITIES) {
            event.accept(DISCO_LILIAN);
        }
    }
}
