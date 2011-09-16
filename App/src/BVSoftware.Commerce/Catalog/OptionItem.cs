﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using BVSoftware.CommerceDTO.v1.Catalog;

namespace BVSoftware.Commerce.Catalog
{
    public class OptionItem
    {       
        public string Bvin {get;set;}
        public long StoreId {get;set;}
        public string OptionBvin {get;set;}
        public string Name {get;set;}
        public decimal PriceAdjustment {get;set;}
        public decimal WeightAdjustment {get;set;}
        public bool IsLabel {get;set;}
        public int SortOrder {get;set;}

        public OptionItem()
        {
            this.Bvin = string.Empty;
            this.StoreId = 0;
            this.OptionBvin = string.Empty;
            this.Name = string.Empty;
            this.PriceAdjustment = 0;
            this.WeightAdjustment = 0;
            this.IsLabel = false;
            this.SortOrder = 0;
        }

        //DTO
        public OptionItemDTO ToDto()
        {
            OptionItemDTO dto = new OptionItemDTO();

            dto.Bvin = this.Bvin;
            dto.IsLabel = this.IsLabel;
            dto.Name = this.Name;
            dto.OptionBvin = this.OptionBvin;
            dto.PriceAdjustment = this.PriceAdjustment;
            dto.SortOrder = this.SortOrder;
            dto.StoreId = this.StoreId;
            dto.WeightAdjustment = this.WeightAdjustment;

            return dto;
        }
        public void FromDto(OptionItemDTO dto)
        {
            if (dto == null) return;

            this.Bvin = dto.Bvin ?? string.Empty;
            this.IsLabel = dto.IsLabel;
            this.Name = dto.Name ?? string.Empty;
            this.OptionBvin = dto.OptionBvin ?? string.Empty;
            this.PriceAdjustment = dto.PriceAdjustment;
            this.SortOrder = dto.SortOrder;
            this.StoreId = dto.StoreId;
            this.WeightAdjustment = dto.WeightAdjustment;
        }

    }
}
